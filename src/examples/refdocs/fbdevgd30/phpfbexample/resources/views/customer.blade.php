@extends('example')

@section('title','Customers')

@section('body')

    <h1>Customers</h1>
    <p>
        {!! $filter !!}
        {!! $grid !!}
    </p>
@stop

