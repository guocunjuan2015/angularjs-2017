<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
 <html ng-app="myApp">
   <head>
     <script src="js/frame/angular.min.js"></script>
     <script src="js/main.js"></script>
   </head>
   <body>
   
   <!-- <div>{{ name }}</div>
   
   <div ng-controller="MyController">
  {{ person.name }}
  
  <div ng-controller="ParentController">
  <div ng-controller="ChildController">
    <input type="text" ng-model="person.name" placeholder="please input"></input>
    <a ng-click="sayHello()">Say hello</a>
  </div>
  {{ person }}
  
  <div ng-controller="PlayerController">
  <button ng-click="play()" class="button" ng-show="!playing">Play</button>
  ng-show true/false控制显示或隐藏
  <button ng-click="stop()" class="button alert" ng-show="playing">Stop</button>
  Playing audio: <b>{{ playing }}</b>
   -->
  
 <!--  <----3----->
 <div ng-controller="MyController">
  <input type="text" ng-model="person.name" placeholder="Enter your name" />
  <h5 ng-click="request()">{{person}}</h5>
  <button ng-init="shouldShow = true" ng-click="shouldShow = !shouldShow">Flip the shouldShow variable</button>
 <div ng-show="shouldShow">
   <h3>Showing {{ shouldShow }}</h3>
 </div> <div ng-hide="shouldShow">
   <h3>Hiding {{ shouldShow }}</h3>
 </div>
</div>
</div>
</div>
</div>
   </body>
 </html>