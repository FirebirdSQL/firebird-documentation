@extends('example')

@section('title','Products')

@section('body')

    <h1>Products</h1>
    <p>
        {!! $filter !!}
        {!! $grid !!}
    </p>
@stop

