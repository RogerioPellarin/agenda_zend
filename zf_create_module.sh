#!/bin/bash
if [ $# -lt 1 ]; then
   echo "Faltou informar o nome do modulo!"
   exit 1
fi
 
lower="${1,,}"
ucfirst=`sed 's/\(.\)/\U\1/' <<< "$lower"`

echo "Criando Modulos"

mkdir -p module/"$ucfirst"/config
mkdir -p module/"$ucfirst"/src/Controller
mkdir -p module/"$ucfirst"/src/Form
mkdir -p module/"$ucfirst"/src/Model
mkdir -p module/"$ucfirst"/view/"$lower"/"$lower"
touch  module/"$ucfirst"/src/Module.php
touch module/"$ucfirst"/view/"$lower"/"$lower"/index.phtml
touch module/"$ucfirst"/view/"$lower"/"$lower"/add.phtml
touch module/"$ucfirst"/view/"$lower"/"$lower"/edit.phtml
touch module/"$ucfirst"/view/"$lower"/"$lower"/delete.phtml

echo '<?php

namespace '"$ucfirst"';

use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;
use Zend\ModuleManager\Feature\ConfigProviderInterface;

class Module implements ConfigProviderInterface {

    public function getConfig() {
        return include __DIR__.'\''/../config/module.config.php'\'';
    }

    public function getServiceConfig()
    {
        return [
           '\''factories'\'' => [
                Model\'"$ucfirst"'Table::class => function($container) {
                    $tableGateway = $container->get(Model\'"$ucfirst"'TableGateway::class);
                    return new Model\'"$ucfirst"'Table($tableGateway);
                },
                Model\'"$ucfirst"'TableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\'"$ucfirst"'());
                    return new TableGateway('\'''"$lower"''\'', $dbAdapter, null, $resultSetPrototype);
                },
            ],
        ];
    }

    public function getControllerConfig()
    {
        return [
            '\''factories'\'' => [
                Controller\'"$ucfirst"'Controller::class => function($container) {
                    return new Controller\'"$ucfirst"'Controller(
                        $container->get(Model\'"$ucfirst"'Table::class)
                    );
                },
            ],
        ];
    }
}
' > module/"$ucfirst"/src/Module.php

touch module/"$ucfirst"/config/module.config.php
echo '<?php

namespace '"$ucfirst"';

use Zend\Router\Http\Segment;
use Zend\ServiceManager\Factory\InvokableFactory;

return [
    '\''controllers'\'' => [
        '\''factories'\'' => [
            Controller\'"$ucfirst"'Controller::class => InvokableFactory::class,
        ],
    ],


    '\''router'\'' => [
        '\''routes'\'' => [
            '\'''"$lower"''\'' => [
                '\''type'\''    => Segment::class,
                '\''options'\'' => [
                    '\''route'\'' => '\''/'"$lower"'[/:action[/:id]]'\'',
                    '\''constraints'\'' => [
                        '\''action'\'' => '\''[a-zA-Z][a-zA-Z0-9_-]*'\'',
                        '\''id'\''     => '\''[0-9]+'\'',
                    ],
                    '\''defaults'\'' => [
                        '\''controller'\'' => Controller\'"$ucfirst"'Controller::class,
                        '\''action'\''     => '\''index'\'',
                    ],
                ],
            ],
        ],
    ],


    '\''view_manager'\'' => [
        '\''template_path_stack'\'' => [
            '\'''"$lower"''\'' => __DIR__ . '\''/../view'\'',
        ],
    ],
];
' > module/"$ucfirst"/config/module.config.php

echo '<?php

namespace '"$ucfirst"'\Controller;

use '"$ucfirst"'\Model\'"$ucfirst"'Table;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class '"$ucfirst"'Controller extends AbstractActionController
{
    private $table;

    public function __construct('"$ucfirst"'Table $table)
    {
        $this->table = $table;
    }

    public function indexAction()
    {
    }

    public function addAction()
    {
    }

    public function editAction()
    {
    }

    public function deleteAction()
    {
    }
}
' > module/"$ucfirst"/src/Controller/"$ucfirst"Controller.php


echo '<?php

namespace '"$ucfirst"'\Model;

class '"$ucfirst"'
{
    public $id;

    public function exchangeArray(array $data)
    {
        $this->id     = !empty($data['\''id'\'']) ? $data['\''id'\''] : null;
    }
}
' > module/"$ucfirst"/src/Model/"$ucfirst".php

echo '<?php

namespace Album\Model;

use RuntimeException;
use Zend\Db\TableGateway\TableGatewayInterface;

class AlbumTable
{
    private $tableGateway;

    public function __construct(TableGatewayInterface $tableGateway)
    {
        $this->tableGateway = $tableGateway;
    }

    public function fetchAll()
    {
        return $this->tableGateway->select();
    }

}

' > module/"$ucfirst"/src/Model/"$ucfirst"Table.php

echo "Script finalizado

Nao esqueça de ajustar os seguintes arquivos:

./composer.json
incluir em > autoload > psr-4 > \"""$ucfirst""\\\": \"module/""$ucfirst""""/src/\"
"

echo "
\$ composer dump-autoload


./config/modules.config.php
incluir em return [ "\'""$ucfirst""\',"
"
