@extends('master')

@section('title','Laravel with Firebird')


@section('body')


<h1>Example</h1>

@if(Session::has('message'))
    <div class="alert alert-success">
        {!! Session::get('message') !!}
    </div>
@endif

<p>Laravel with Firebird.<br/>

</p>


@stop


@section('content')

    @include('menu')

    @yield('body')


@stop

