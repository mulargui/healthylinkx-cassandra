# healthylinkx-cassandra

Healthylinkx helps you find doctors with the help of your social network. Think of Healthylinkx as a combination of Yelp, Linkedin and Facebook. 

This is an early prototype that combines open data of doctors and specialists from the US Department of Health. It allows you to search for doctors based on location, specialization, genre or name. You can choose up to three doctors in the result list and Healthylinkx (theoretically) will book appointments for you.

Healthylinx is a classic three tiers app: front-end (ux), service API and data store. It also integrates with a third-party API from RedLine13 (https://www.redline13.com) to find zip codes in an area.

This architecture makes it very adequate to test different technologies and I use it for getting my hands dirty on new stuff. You might need to combine what is in this repo with other repos if you want to build the app end to end. It is like a lego where you can pick and choose different technologies as you see fit. Enjoy!

Thios repo implements the service API in node.js to use cassandra as a data store. The data folder contains the scripts to recreate the data model in cassandra.
