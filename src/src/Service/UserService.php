<?php

namespace App\Service;

class UserService
{
    private array $users = [];

    public function addUser(string $email, string $name): void
    {
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new \InvalidArgumentException('Invalid email format');
        }

        if (empty($name)) {
            throw new \InvalidArgumentException('Name cannot be empty');
        }

        $this->users[$email] = [
            'email' => $email,
            'name' => $name,
        ];
    }

    public function getUser(string $email): ?array
    {
        return $this->users[$email] ?? null;
    }

    public function getAllUsers(): array
    {
        return array_values($this->users);
    }
}
