@extends('example')

@section('title','Invoice editor')

@section('body')

    <div class="container">
        {!! $edit->header !!}
        
        @if($error_msg)
            <div class="alert alert-danger">
                <strong>Error!</strong> {{ $error_msg }}
            </div>           
        @endif
        
        {!! $edit->message !!}

        @if(!$edit->message)
        
            <div class="row">
                <div class="col-sm-4">
                    {!! $edit->render('INVOICE_DATE') !!}
                    {!! $edit->render('customer.NAME') !!}
                    {!! $edit->render('TOTAL_SALE') !!}
                    {!! $edit->render('PAID') !!}
                </div>            
            </div>
        
            {!! $grid !!}
        
        @endif
        
        {!! $edit->footer !!}
    </div>
@stop

