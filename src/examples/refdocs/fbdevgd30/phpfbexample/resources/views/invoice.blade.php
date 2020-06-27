@extends('example')

@section('title','Invoices')

@section('body')

    <h1>Invoices</h1>
    <p>
        {!! $filter !!}
        {!! $grid !!}
    </p>
@stop

