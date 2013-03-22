# cloud-box.js
# GBCloudBox

# Created by Luka Mirosevic on 20/03/2013.
# Copyright (c) 2013 Goonbee. All rights reserved.

# Licensed under the Apache License, Version 2.0 (the "License")
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


############################################### MANIFEST ###############################################

RESOURCES_META_PATH = "GBCloudBoxResourcesMeta"
RESOURCES_DATA_PATH = "GBCloudBoxResourcesData"

RESOURCES_MANIFEST_LOCAL = [
   "Facebook.js",
]
RESOURCES_MANIFEST_EXTERNAL = {
    # "Facebook2.js" : {"v" : "3", "url" : "https://www.goonbee.com/some/path/Facebook.js"},
}

cloudBox = () ->
   ############################################### INIT ###############################################
   express = require('express')

   PORT = process.env.PORT || 5000
   USE_SSL = undefined

   app = express()

   app.configure('development', () -> 
      USE_SSL = no
   )

   app.configure('production', () ->
      USE_SSL = yes
   )

   console.log USE_SSL
   http_s = if USE_SSL then require('https') else require('http')
   server = http_s.createServer(app);

   fs = require('fs')

   ############################################### HELPERS ###############################################

   error400 = (request, response) ->
      response.statusCode = 404
      response.end()

   latestVersionForLocalResource = (resource) ->
      local_path = "res/#{resource}"

      if fs.existsSync(local_path)#foo
         fs.readdirSync(local_path).reduce (a,b) -> Math.max a, b
      else
         null

   publicPathForLocalResource = (request, resource) ->
      protocol = if USE_SSL then "https" else "http"
      "#{protocol}://#{request.headers.host}/#{RESOURCES_DATA_PATH}/#{resource}"

   localPathForLocalResource = (resource) ->
      "res/#{resource}/#{latestVersionForLocalResource(resource)}"

   ############################################### META ROUTE ###############################################

   app.get("/#{RESOURCES_META_PATH}/:resource_identifier", (request, response) ->
      identifier = request.params.resource_identifier

      #if its a local resource, get the public path. if its an external resource the path is already set
      if identifier in RESOURCES_MANIFEST_LOCAL
         response.setHeader 'Content-Type', 'application/json'

         response.end(JSON.stringify({
            "v" : latestVersionForLocalResource(identifier),
            "url" : publicPathForLocalResource(request, identifier)
         }))
      else if resource = RESOURCES_MANIFEST_EXTERNAL[identifier]
         response.end(JSON.stringify(resource))
      else
         error400(request, response)
   )

   ############################################### DATA ROUTE ###############################################


   app.get("/#{RESOURCES_DATA_PATH}/:resource_identifier", (request, response) ->
      identifier = request.params.resource_identifier

      #get path
      path = localPathForLocalResource(identifier)

      #make sure file exists
      fs.exists(path, (exists) ->
         if exists
            response.sendFile(path)
         else
            error400(request, response)
      )
   )

   ############################################### LAUNCH ###############################################

   server.listen(PORT, () ->
      console.log("GBCloudBox Server: Listening on port " + PORT + "!")
   )

# Export server as start function which when called starts the server
exports.start = cloudBox