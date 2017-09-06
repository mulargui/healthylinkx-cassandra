
var cassandra=require("cassandra-driver");
var url = require("url");
var constants = require("./constants.js");
var dns = require('dns');
var wait=require('wait.for');

// a utility function to write header info
function reply(response, code, results) {
	response.writeHead(code, {"Content-Type": "application/json"}); 
	response.write(JSON.stringify(results));
	response.end();
	console.log("%d", code);
}

function initclient(){
	var dbhost;
	try{
		dbhost = wait.for(dns.lookup,constants.host);
	} catch(err){
		dbhost='172.17.0.2';
	}

	return new cassandra.Client({ contactPoints: [dbhost], keyspace: constants.database });
}
const client = initclient();

// =======================================================================================
// messages
// =======================================================================================
 
function taxonomy(request, response) {
	client.execute("SELECT * FROM taxonomy", function(err,result){		
		if (err) throw err;
		reply(response, 200, result.rows);
	});
}

function providers(request, response) {
	var params = url.parse(request.url,true).query; 

	var gender=params.gender;
	var lastname1=params.lastname1;
	var lastname2=params.lastname2;
	var lastname3=params.lastname3;
	var specialty=params.specialty;
	var distance=params.distance;
	var zipcode=params.zipcode;
 	
 	//check params
 	if(!zipcode && !lastname1 && !specialty){
		reply(response, 204, '');
		return;
 	}

	//select table to use depending on params
	var table = "npidatabyname";
	if (!lastname1 && specialty) table = "npidatabyname";
	if (!lastname1 && !specialty) table = "npidatabyzipcode";
	
 	var query = "SELECT NPI,Provider_Full_Name,Provider_Full_Street,Provider_Full_City FROM " + table + " WHERE ";
 	if (lastname1){
 		query += "Provider_Last_Name_Legal_Name IN ('" + lastname1 + "'";
		if (lastname2) query += ", '" + lastname2 + "'";
		if (lastname3) query += ", '" + lastname3 + "'";
 		query += ") ";
	}
 	if(gender){
 		if(lastname1) query += "AND ";
 		query += "Provider_Gender_Code = '" + gender + "' ";
	}
 	if(specialty){
 		if(lastname1 || gender) query += "AND ";
 		query += "Classification = '" + specialty + "' ";
	}
 	//case 1: no need to calculate zip codes at a distance
 	if (!distance || !zipcode){
 		if(zipcode){
 			if(lastname1 || gender || specialty) query += "AND ";
 			query += "Provider_Short_Postal_Code = '" + zipcode + "' ";
		}
		query += " limit 50 ALLOW FILTERING";
 		
		console.log(query);
		client.execute(query, function(err,result){		
			if (err) throw err;
			reply(response, 200, result.rows);
		});
		return;
	}

 	//case 2:we need to find zipcodes at a distance

 	//lets get a few zipcodes
 	var queryapi = "/rest/GFfN8AXLrdjnQN08Q073p9RK9BSBGcmnRBaZb8KCl40cR1kI1rMrBEbKg4mWgJk7/radius.json/" + zipcode + "/" + distance + "/mile";
	var responsestring="";

	var options = {
  		host: "zipcodedistanceapi.redline13.com",
  		path: queryapi
 	};

	var req = require("http").request(options, function(res) {
		res.setEncoding('utf8');
		res.on('data', function (chunk) {
			responsestring += chunk;
		});

		res.on('error', function(e) {
			throw e;
		});	

		res.on('end', function() {

			//no data
  			if (!responsestring) {	
				reply(response, 204, '');
				return;
 			}

		 	//translate json from string to array
			var responsejson = JSON.parse(responsestring);
			var length=responsejson.zip_codes.length;

			//complete the query
 			if(lastname1 || gender || specialty) query += "AND ";
 			query += "Provider_Short_Postal_Code IN ('"+responsejson.zip_codes[0].zip_code+"'";
			for (var i=1; i<length;i++){
 				query += ", '"+ responsejson.zip_codes[i].zip_code +"'";
			}
  			query += ") limit 50 ALLOW FILTERING";

			console.log(query);
			client.execute(query, function(err,result){		
				if (err) throw err;
				reply(response, 200, result.rows);
			});
		});
	}).end();		
}

function transaction(request, response) {
	var params = url.parse(request.url,true).query; 
	var id=params.id;
 
 	//check params
 	if(!id){
		reply(response, 204, '');
		return;
 	}

	//retrieve the providers
	var query = "SELECT * FROM transactions WHERE id = "+id;
	client.execute(query, function(err,results){		
		if (err) throw err;

		if (results.rows[0].length <= 0){
			reply(response, 204, '');
			return;
 		}

		//get the providers
		var npi1 = results.rows[0].npi1;
		var npi2 = results.rows[0].npi2;
		var npi3 = results.rows[0].npi3;
	
		//get the details of the providers
		query = "SELECT NPI,Provider_Full_Name,Provider_Full_Street, Provider_Full_City, Provider_Business_Practice_Location_Address_Telephone_Number FROM npidata2 WHERE NPI IN ('"+npi1+"'";
		if(npi2) query += ", '"+npi2+"'";
		if(npi3) query += ", '"+npi3+"'";
		query += ")";

 		client.execute(query, function(err,result){		
			if (err) throw err;
			reply(response, 200, result.rows);
		});
	});
}

function shortlist(request, response) {
	var params = url.parse(request.url,true).query; 
	var npi1 = params.NPI1;
	var npi2 = params.NPI2;
	var npi3 = params.NPI3;

 	//check params
 	if(!npi1){
		reply(response, 204, '');
		return;
 	}
	
	//save the selection
	var query = "INSERT INTO transactions (id, NPI1, NPI2, NPI3) VALUES (now(),'"+ npi1 +"','"+ npi2 +"','"+npi3 +"')";
 	client.execute(query, function(err,results){		
		if (err) throw err;

		//keep the transaction number, need to solve this piece in cassandra
		//var transactionid= results.insertId;
			
		//return detailed data of the selected providers
		query = "SELECT NPI,Provider_Full_Name,Provider_Full_Street, Provider_Full_City, Provider_Business_Practice_Location_Address_Telephone_Number FROM npidata2 WHERE NPI IN ('"+npi1+"'";
		if(npi2) query += ", '"+npi2+"'";
		if(npi3) query += ", '"+npi3+"'";
		query += ")";

 		client.execute(query, function(err,result){		
			if (err) throw err;
			
			var info=[{Transaction: 0000}];
			info.push(result.rows);
			reply(response, 200, info);
		});
	});
}

exports.taxonomy=taxonomy;
exports.providers=providers;
exports.shortlist=shortlist;
exports.transaction=transaction;
