<?php

namespace Agenda\Controller;

use Agenda\Model\AgendaTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class AgendaController extends AbstractActionController
{
    private $table;

    public function __construct(AgendaTable $table)
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

