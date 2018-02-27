<nav class="navbar main">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".main-collapse">
            <span class="sr-only"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
    </div>
    <div class="collapse navbar-collapse main-collapse">
        <ul class="nav nav-tabs">
            <li @if (Request::is('customer*')) class="active"@endif>{!! link_to("customers", "Customers") !!}</li>
            <li @if (Request::is('product*')) class="active"@endif>{!! link_to("products", "Products") !!}</li>
            <li @if (Request::is('invoice*')) class="active"@endif>{!! link_to("invoices", "Invoices") !!}</li>
        </ul>
    </div>
</nav>
