<?php

namespace classes;

class Account {

    public string $username;
    public array $orders;

    public function __construct($username) {

        $this->username = $username;
        $this->orders   = [];

    }

    public function addOrder($order) {

        $this->orders[] = $order;

    }

}