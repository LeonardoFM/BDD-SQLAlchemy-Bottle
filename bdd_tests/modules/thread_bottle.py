from bottle import WSGIRefServer
from wsgiref.simple_server import WSGIRequestHandler, WSGIServer
from wsgiref.simple_server import make_server


class FixedHandler(WSGIRequestHandler):
    def address_string(self):
        """Prevent reverse DNS lookups please."""
        return self.client_address[0]


class MyServer(WSGIRefServer):
    def run(self, app):
        """pragma: no cover."""
        handler_cls = self.options.get('handler_class', FixedHandler)
        server_cls = self.options.get('server_class', WSGIServer)

        srv = make_server(self.host, self.port, app, server_cls, handler_cls)
        #
        self.srv = srv
        srv.serve_forever()

    def shutdown(self):
        """ADD SHUTDOWN METHOD."""
        self.srv.shutdown()
