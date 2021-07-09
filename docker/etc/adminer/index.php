<?php

namespace docker {
    function adminer_object()
    {
        include_once 'plugins/plugin.php';

        class Adminer extends \AdminerPlugin
        {
            function _callParent($function, $args)
            {
                if ($function === 'loginForm') {
                    ob_start();
                    $return = \Adminer::loginForm();
                    $form = ob_get_clean();

                    echo str_replace('name="auth[server]" value="" title="hostname[:port]"', 'name="auth[server]" value="'.($_ENV['ADMINER_DEFAULT_SERVER'] ?: 'db').'" title="hostname[:port]"', $form);

                    return $return;
                }

                return parent::_callParent($function, $args);
            }
        }

        include_once "plugins/AdminerTheme.php";

        $theme = $_ENV['ADMINER_THEME'] ?: 'default-blue';

        $plugins = [
            new \AdminerTheme($theme),
        ];

        foreach (glob('plugins-enabled/*.php') as $plugin) {
            $plugins[] = include $plugin;
        }

        return new Adminer($plugins);
    }
}

namespace {
    if (basename($_SERVER['DOCUMENT_URI']) === 'adminer.css' && is_readable('adminer.css')) {
        header('Content-Type: text/css');
        readfile('adminer.css');
        exit;
    }

    function adminer_object()
    {
        return \docker\adminer_object();
    }

    include 'adminer.php';
}
