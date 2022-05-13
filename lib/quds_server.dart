/// A core server for creating fast dart servers with support of routers, controllers, middlewares.
library quds_server;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

// JWT (Json Web Kit)
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:redis/redis.dart';
//Shelf
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart' as validators;

//Authorization
part 'authorization/token_pair.dart';
part 'authorization/token_service.dart';
part 'authorization/token_service_configurations.dart';
part 'authorization/utils.dart';
// Controllers
part 'controllers/quds_controller.dart';
part 'formatter/formatter.dart';
part 'middlewares/auth_middlewares.dart';
part 'middlewares/body_generator.dart';
part 'middlewares/cors_middlewares.dart';
part 'middlewares/logging_middlewares.dart';
// Middlewares
part 'middlewares/quds_middleware.dart';
//Routing
part 'routing/quds_router.dart';
part 'routing/quds_router_handler.dart';
part 'routing/route_method.dart';
// Server
part 'server/quds_server.dart';
part 'server/server_configurations.dart';
part 'server/server_status_code.dart';
part 'server/server_status_code_group.dart';
// Validation
part 'validation/api_validation.dart';
part 'validation/booleans.dart';
part 'validation/commons.dart';
part 'validation/datetimes.dart';
part 'validation/lists.dart';
part 'validation/numbers.dart';
part 'validation/strings.dart';
