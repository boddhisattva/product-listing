App = angular.module('ProductListing', ['ngRoute','ngResource']);

App.factory('Products', ['$resource',function($resource){
  return $resource('/api/v1/products.json', {},{
    query: { method: 'GET', isArray: true },
    create: { method: 'POST' }
  });
}]);

App.factory('Product', ['$resource', function($resource){
  return $resource('/api/v1/products/:id.json', {}, {
    show: { method: 'GET' },
    update: { method: 'PUT', params: {id: '@id'} },
    delete: { method: 'DELETE', params: {id: '@id'} }
  });
}]);

App.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider.when('/products',{
    templateUrl: 'templates/products/index.html',
    controller: 'ProductListCtr'
 });
  $routeProvider.when('/products/new', {
    templateUrl: 'templates/products/new.html',
    controller: 'ProductAddCtr'
 });
  $routeProvider.when('/products/:id/edit', {
    templateUrl: 'templates/products/edit.html',
    controller: "ProductUpdateCtr"
 });
  $routeProvider.otherwise({
    redirectTo: '/products'
  });
 }
]);

App.controller("ProductListCtr", ['$scope', '$http', '$resource', 'Products', 'Product', '$location', function($scope, $http, $resource, Products, Product, $location) {

  $scope.products = Products.query();

}]);