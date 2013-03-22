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
   express = require 'express'
   http = require 'http'
   fs = require 'fs'

   PORT = process.env.PORT || 5000
   USE_SSL = undefined

   app = express()
   server = http.createServer(app);

   ############################################### CONFIG ###############################################

   app.configure 'development', () -> 
      USE_SSL = no

   app.configure 'production', () ->
      USE_SSL = yes

   ############################################### HELPERS ###############################################

   error400 = (request, response) ->
      response.statusCode = 404
      response.end()

   latestVersionForLocalResource = (resource, callback) ->
      local_path = "res/#{resource}"

      fs.exists local_path, (exists) -> 
         if exists
            fs.readdir local_path, (err, files) ->
               callback files.reduce (a,b) -> Math.max a, b
         else
            null

   publicPathForLocalResource = (request, resource) ->
      protocol = if USE_SSL then "https" else "http"
      "#{protocol}://#{request.headers.host}/#{RESOURCES_DATA_PATH}/#{resource}"

   localPathForLocalResource = (resource, callback) ->
      latestVersionForLocalResource resource, (latestVersion) -> 
         callback "res/#{resource}/#{latestVersion}"

   ############################################### META ROUTE ###############################################

   app.get "/#{RESOURCES_META_PATH}/:resource_identifier", (request, response) ->
      identifier = request.params.resource_identifier

      #if its a local resource, get the public path. if its an external resource the path is already set
      if identifier in RESOURCES_MANIFEST_LOCAL
         latestVersionForLocalResource identifier, (latestVersion) -> 
            response.setHeader 'Content-Type', 'application/json'

            response.end(JSON.stringify({
               "v" : latestVersion,
               "url" : publicPathForLocalResource(request, identifier)
            }))
      else if resource = RESOURCES_MANIFEST_EXTERNAL[identifier]
         response.end(JSON.stringify(resource))
      else
         error400(request, response)

   ############################################### DATA ROUTE ###############################################

   app.get "/#{RESOURCES_DATA_PATH}/:resource_identifier", (request, response) ->
      identifier = request.params.resource_identifier

      #get path
      localPathForLocalResource identifier, (path) ->
         #make sure file exists
         fs.exists path, (exists) ->
            if exists
               response.sendfile(path)
            else
               error400(request, response)

   ############################################### LAUNCH ###############################################
   
   server.listen PORT, () ->
      console.log("GBCloudBox Server: Listening on port " + PORT + "!")

# Export server as start function which when called starts the server
exports.start = cloudBox