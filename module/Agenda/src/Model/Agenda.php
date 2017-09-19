<?php

namespace Agenda\Model;

class Agenda
{
    public $id;

    public function exchangeArray(array $data)
    {
        $this->id     = !empty($data['id']) ? $data['id'] : null;
    }
}

