part of quds_server;

enum RouteMethod {
  /// The HTTP GET method is used to read (or retrieve) a representation of a resource. In case of success (or non-error), GET returns a representation in JSON and an HTTP response status code of 200 (OK). In an error case, it most often returns a 404 (NOT FOUND) or 400 (BAD REQUEST).
  get,

  /// The POST method is most often utilized to create new resources. In particular, it is used to create subordinate resources. That is subordinate to some other (e.g. parent) resource. In other words, when creating a new resource, POST to the parent and the service takes care of associating the new resource with the parent, assigning an ID (new resource URI), etc.
  ///
  /// On successful creation, HTTP response code 201 is returned.
  post,

  /// PATCH is used to modify resources. The PATCH request only needs to contain the changes to the resource, not the complete resource.
  ///
  /// In other words, the body should contain a set of instructions describing how a resource currently residing on the server should be modified to produce a new version.
  patch,

  /// DELETE is quite easy to understand. It is used to delete a resource identified by filters or ID.
  ///
  /// On successful deletion, the HTTP response status code 204 (No Content) returns with no response body.
  delete,
  put,
  head,
  options
}
