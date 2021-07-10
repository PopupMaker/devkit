<?php
/**
 * Config
 *
 * @package App
 */

declare( strict_types = 1 );
require_once dirname( __DIR__ ) . '/vendor/autoload.php';
require_once dirname( __DIR__ ) . '/config/application.php';
require_once ABSPATH . 'wp-settings.php';


/**
 * Automatically handle enqueueing livereload if available.
 */
add_action( 'admin_enqueue_scripts', function () {
	if ( ! defined( WP_ENV ) || 'production' === WP_ENV ) {
		return;
	}

	if ( curl_init( 'http://localhost:35729/livereload.js' ) !== false ) {
		wp_enqueue_script( 'webpack-live-reload', 'http://localhost:35729/livereload.js', [], '0.0.0', false );
	}
} );
