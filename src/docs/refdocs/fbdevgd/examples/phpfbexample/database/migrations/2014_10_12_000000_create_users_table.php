<?php

use Firebird\Schema\Blueprint;
//use Firebird\Schema\SequenceBlueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // выполнит оператор 
        // CREATE SEQUENCE "seq_users_id"
        //Schema::createSequence('seq_users_id');
        // выполнит операторы
        // CREATE TABLE "users" (
        //   "id"              INTEGER NOT NULL,
        //   "name"            VARCHAR(255) NOT NULL,
        //   "email"           VARCHAR(255) NOT NULL,
        //   "password"        VARCHAR(255) NOT NULL,
        //   "remember_token"  VARCHAR(100),
        //   "created_at"      TIMESTAMP,
        //   "updated_at"      TIMESTAMP
        // );
        // ALTER TABLE "users" ADD PRIMARY KEY ("id");
        // ALTER TABLE "users" ADD CONSTRAINT "users_email_unique" UNIQUE ("email");
        Schema::create('users', function (Blueprint $table) {
            //$table->useIdentity(); // only Firebird 3.0
            $table->increments('id');
            //$table->integer('id')->primary();
            $table->string('name');
            $table->string('email')->unique();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
        });
        // выполнит оператор
        // ALTER SEQUENCE "seq_users_id" RESTART WITH 10 INCREMENT BY 5
        //Schema::sequence('seq_users_id', function (SequenceBlueprint $sequence) {
        //    $sequence->increment(5);
        //    $sequence->restart(10);
        //});
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // выполнит оператор 
        // DROP SEQUENCE "seq_users_id"
        //Schema::dropSequence('seq_users_id');
        // выполнит оператор 
        // DROP TABLE "users"        
        Schema::drop('users');
    }
}
