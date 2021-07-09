<?php
/**
 * Application production config.
 *
 * @package App
 *
 * phpcs:disable WordPress.NamingConventions.PrefixAllGlobals
 */

declare( strict_types = 1 );

define( 'WP_DEBUG_DISPLAY', false );
define( 'SCRIPT_DEBUG', false );

// Disable all file modifications including updates and update notifications.
define( 'DISALLOW_FILE_MODS', true );
