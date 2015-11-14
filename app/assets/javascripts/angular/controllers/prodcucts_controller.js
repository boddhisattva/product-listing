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
    controller: 'ProductListCtrl'
 });
  $routeProvider.when('/products/new', {
    templateUrl: 'templates/products/new.html',
    controller: 'ProductAddCtrl'
 });
  $routeProvider.when('/products/:id/edit', {
    templateUrl: 'templates/products/edit.html',
    controller: "ProductUpdateCtrl"
 });
  $routeProvider.otherwise({
    redirectTo: '/products'
  });
 }
]);

App.controller("ProductListCtrl", ['$scope', '$http', '$resource', 'Products', 'Product', '$location', function($scope, $http, $resource, Products, Product, $location) {

  $scope.products = Products.query();

}]);

App.controller("ProductAddCtrl", ['$scope', '$resource', 'Products', '$location', function($scope, $resource, Products, $location) {
  $scope.product = {};
  $scope.save = function () {
    if ($scope.productForm.$valid){
      Products.create({product: $scope.product}, function(){
      $location.path('/');
    }, function(error){
      console.log(error);
    });
  }
 };
}]);

App.controller("ProductUpdateCtrl", ['$scope', '$resource', 'Product', '$location', '$routeParams', function($scope, $resource, Product, $location, $routeParams) {
   $scope.product = Product.get({id: $routeParams.id});
   $scope.update = function(){
     if ($scope.productForm.$valid){
       Product.update($scope.product, function(){
         $location.path('/');
       }, function(error) {
         console.log(error);
      });
     }
   };
}]);
