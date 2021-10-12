/// A core server for creating fast dart servers with support of routers, controllers, middlewares.
library quds_server;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:validators/validators.dart' as validators;

//Shelf
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// JWT (Json Web Kit)
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:redis/redis.dart';
import 'package:uuid/uuid.dart';

//Authorization
part 'authorization/token_pair.dart';
part 'authorization/token_service.dart';
part 'authorization/token_service_configurations.dart';
part 'authorization/utils.dart';

// Server
part 'server/quds_server.dart';
part 'server/server_configurations.dart';
part 'formatter/formatter.dart';
part 'formatter/api_validation.dart';

// Middlewares
part 'middlewares/quds_middleware.dart';
part 'middlewares/auth_middlewares.dart';
part 'middlewares/logging_middlewares.dart';
part 'middlewares/cors_middlewares.dart';

//Routing
part 'routing/quds_router.dart';
part 'routing/quds_router_handler.dart';
part 'routing/route_method.dart';

// Controllers
part 'controllers/quds_controller.dart';
