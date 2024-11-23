<?php

namespace App\Tests\Service;

use App\Service\UserService;
use PHPUnit\Framework\TestCase;

class UserServiceTest extends TestCase
{
    private UserService $userService;

    protected function setUp(): void
    {
        $this->userService = new UserService();
    }

    public function testAddValidUser(): void
    {
        $this->userService->addUser('test@example.com', 'John Doe');
        $user = $this->userService->getUser('test@example.com');

        $this->assertNotNull($user);
        $this->assertEquals('test@example.com', $user['email']);
        $this->assertEquals('John Doe', $user['name']);
    }

    public function testAddUserWithInvalidEmail(): void
    {
        $this->expectException(\InvalidArgumentException::class);
        $this->expectExceptionMessage('Invalid email format');
        
        $this->userService->addUser('invalid-email', 'John Doe');
    }

    public function testAddUserWithEmptyName(): void
    {
        $this->expectException(\InvalidArgumentException::class);
        $this->expectExceptionMessage('Name cannot be empty');
        
        $this->userService->addUser('test@example.com', '');
    }

    public function testGetAllUsers(): void
    {
        $this->userService->addUser('user1@example.com', 'User One');
        $this->userService->addUser('user2@example.com', 'User Two');

        $users = $this->userService->getAllUsers();

        $this->assertCount(2, $users);
        $this->assertEquals('User One', $users[0]['name']);
        $this->assertEquals('User Two', $users[1]['name']);
    }

    public function testGetNonExistentUser(): void
    {
        $user = $this->userService->getUser('nonexistent@example.com');
        $this->assertNull($user);
    }
}
