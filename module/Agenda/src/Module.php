<?php

namespace Agenda;

use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;
use Zend\ModuleManager\Feature\ConfigProviderInterface;

class Module implements ConfigProviderInterface {

    public function getConfig() {
        return include __DIR__.'/../config/module.config.php';
    }

    public function getServiceConfig()
    {
        return [
           'factories' => [
                Model\AgendaTable::class => function($container) {
                    $tableGateway = $container->get(Model\AgendaTableGateway::class);
                    return new Model\AgendaTable($tableGateway);
                },
                Model\AgendaTableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\Agenda());
                    return new TableGateway('agenda', $dbAdapter, null, $resultSetPrototype);
                },
            ],
        ];
    }

    public function getControllerConfig()
    {
        return [
            'factories' => [
                Controller\AgendaController::class => function($container) {
                    return new Controller\AgendaController(
                        $container->get(Model\AgendaTable::class)
                    );
                },
            ],
        ];
    }
}

