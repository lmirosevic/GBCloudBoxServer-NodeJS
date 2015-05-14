GBCloudBox Server (Node.JS)
============

GBCloudBox is a framework for over-the-air, asynchronous, in-the-background, resource syncing between iOS/Mac OS X apps and a server. Let's say your app depends on a javascript resource file called `MyResource.js`, but you want to be able to change it often without resubmitting your entire app to the App Store. GBCloudBox allows you to ship a bundled version of the resource inside your app, publish and distribute your app, and then once the app is out in the wild push updated versions of your resource to the cloud and have your apps in the wild automatically sync the resource as soon as the new one becomes available.

This is a server implementation for the GBCloudBox, and is configured for 1 click deployment to Heroku. This implementation is not as stable/tested as the Ruby one, please use that one instead.

iOS & Mac OS X Client (Objective-C)
------------

See: [github.com/lmirosevic/GBCloudBoxClient](https://github.com/lmirosevic/GBCloudBoxClient)


Copyright & License
------------

Copyright 2013 Luka Mirosevic

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
