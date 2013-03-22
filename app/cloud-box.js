// cloud-box.js
// GBCloudBox

// Created by Luka Mirosevic on 20/03/2013.
// Copyright (c) 2013 Goonbee. All rights reserved.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
 

//Options
var RESOURCES_META_PATH = "GBCloudBoxResourcesMeta"
var RESOURCE_DATA_PATH = "GBCloudBoxResourcesData"

var RESOURSCES_MANIFEST_LOCAL = [
   "Facebook.js",
]
var RESOURSCES_MANIFEST_EXTERNAL = [
//    "Facebook.js" : {"v" : "3", "url" : "https://www.goonbee.com/some/path/Facebook.js"},
]


var cloudBox = function() {
   //Init
   var express = require('express');
   var port = process.env.PORT || 5000;
   var app = express();

   //Helpers
   var Error400 = function (request, response) {
      response.statusCode = 404;
      response.end("bad shit happened");
   };

   //Meta Route
   app.get("/" + RESOURCES_META_PATH + "/:resource_identifier", function (request, response) {
      var identifier = request.params.resource_identifier;

      

      response.setHeader('Content-Type', 'text/plain');
      response.end("hi man");
   });

   // app.get("/bad", function (request, response) {
      // Error400(request, response);
   // });

   //Launch
   app.listen(port, function () {
      console.log("GBCloudBox Server: Listening on port " + port + "!");
   });
}

//Export server as start function which when called starts the server
exports.start = cloudBox;