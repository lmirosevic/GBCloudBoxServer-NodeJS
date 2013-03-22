// CloudBox.js
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

var http = require("http");

// Create the server. Function passed as parameter is called on every request made.
// request variable holds all request parameters
// response variable allows you to do anything with response sent to the client.
http.createServer(function (request, response) {
   // Attach listener on end event.
   // This event is called when client sent all data and is waiting for response.
   request.on("end", function () {
      // Write headers to the response.
      // 200 is HTTP status code (this one means success)
      // Second parameter holds header fields in object
      // We are sending plain text, so Content-Type should be text/plain
      response.writeHead(200, {
         'Content-Type': 'text/plain'
      });
      // Send data and end response.
      response.end('Hello HTTP!');
   });
// Listen on the 7000 port.
}).listen(7000);