<?php

namespace Agenda;

use Zend\Router\Http\Segment;
use Zend\ServiceManager\Factory\InvokableFactory;

return [
    'controllers' => [
        'factories' => [
            Controller\AgendaController::class => InvokableFactory::class,
        ],
    ],


    'router' => [
        'routes' => [
            'agenda' => [
                'type'    => Segment::class,
                'options' => [
                    'route' => '/agenda[/:action[/:id]]',
                    'constraints' => [
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ],
                    'defaults' => [
                        'controller' => Controller\AgendaController::class,
                        'action'     => 'index',
                    ],
                ],
            ],
        ],
    ],


    'view_manager' => [
        'template_path_stack' => [
            'agenda' => __DIR__ . '/../view',
        ],
    ],
];

