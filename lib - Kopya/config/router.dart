import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SizedBox(),
      ),

      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const SizedBox(),
        routes: [
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'register',
            name: 'register',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'forgot-password',
            name: 'forgot-password',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),

      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const SizedBox(),
        routes: [
          GoRoute(
            path: 'dashboard',
            name: 'dashboard',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'floor-plans',
            name: 'floor-plans',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'properties',
            name: 'properties',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'reports',
            name: 'reports',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),

      GoRoute(
        path: '/scan',
        name: 'scan',
        builder: (context, state) => const SizedBox(),
        routes: [
          GoRoute(
            path: 'camera',
            name: 'scan-camera',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'preview',
            name: 'scan-preview',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'processing',
            name: 'scan-processing',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),

      GoRoute(
        path: '/floor-plan/:id',
        name: 'floor-plan-detail',
        builder: (context, state) => const SizedBox(),
        routes: [
          GoRoute(
            path: 'edit',
            name: 'floor-plan-edit',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'view-3d',
            name: 'floor-plan-3d',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'export',
            name: 'floor-plan-export',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'share',
            name: 'floor-plan-share',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),

      GoRoute(
        path: '/property/:id',
        name: 'property-detail',
        builder: (context, state) => const SizedBox(),
        routes: [
          GoRoute(
            path: 'edit',
            name: 'property-edit',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'floor-plans',
            name: 'property-floor-plans',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),

      GoRoute(
        path: '/report/:id',
        name: 'report-detail',
        builder: (context, state) => const SizedBox(),
        routes: [
          GoRoute(
            path: 'preview',
            name: 'report-preview',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'share',
            name: 'report-share',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),

      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const SizedBox(),
        routes: [
          GoRoute(
            path: 'edit',
            name: 'profile-edit',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: 'notifications',
            name: 'notifications',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),

      GoRoute(
        path: '/help',
        name: 'help',
        builder: (context, state) => const SizedBox(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const SizedBox(),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}
