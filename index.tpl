<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MakaBar - Witts Originals</title>
    <link rel="stylesheet" type="text/css" href="main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <script>

        $(document).ready(function() {

            $('.menu-btn').click(function() {
                $('.menu').toggleClass('active');
            });

            var login;

            $('#adminLogin').on('click', function() {
                $.ajax({
                    url: 'login.php',
                    type: 'POST',
                    data: {
                        username : $('#logname').val(),
                        password : $('#logpass').val()
                    },
                    dataType: 'json',
                    success: function(data) {
                        if(data === "success") {
                            login = "true";
                            localStorage.setItem('login', login)
                            $('#login-container').fadeOut();
                            Swal.fire({
                                title: 'Erfolgreich eingeloggt',
                                icon: 'success',
                                confirmButtonText: 'Weiter'
                            }).then(function(result) {
                                window.location.href = '/rezepte.html'
                            });
                        } else {
                            $('#login-container').fadeOut();
                            Swal.fire({
                                title: 'Benutzerdaten falsch',
                                icon: 'error',
                                confirmButtonText: 'Weiter'
                            }).then(function(result) {
                                $('#login-container').fadeIn();
                            });
                        }
                        
                    },
                    error: function(request, error) {
                        $('#login-container').fadeOut();
                        Swal.fire({
                            title: 'Benutzerdaten falsch',
                            icon: 'error',
                            confirmButtonText: 'Weiter'
                        }).then(function(result) {
                            $('#login-container').fadeIn();
                        });
                    }
                });
            });


            $('#close-login').on('click', function() {
                $('#login-container').fadeOut();
            });

            $('.order-btn').on('click', function() {
                var cocktail = $(this).val();
                addOrder(cocktail);
            });

            $('#trash').on('click', function() {
                $('#overlay-cart').fadeOut();
                $('.products').empty();
                $('.details').empty();
                $('.checkout--footer label').empty();
            });

            var name = localStorage.getItem('name')

            if(name) {
                $('#overlay').hide();
                $('#greetingname').text(name);
                $('.greeting').show();
                $('#logout').show();

                $('#logout').click(function() {
                    Swal.fire({
                        title: 'Ausloggen',
                        icon: 'warning',
                        text: 'Möchtest du dich wirklich ausloggen?',
                        showCancelButton: true,
                        confirmButtonText: 'Weiter',
                        cancelButtonText: 'Zurück',
                    }).then(function(result) {
                        if(result.isConfirmed) {
                            localStorage.removeItem('name');
                            $('#greetingname').empty();
                            $('.greeting').hide();
                            location.reload();
                        }
                    });
                });
            } else {
                $('#logout').hide();
                $('.greeting').hide();
                $('#overlay').show();
                $('#submit-btn').click(function() {
                    var enteredName = $('#prename').val();
                    if(enteredName) {
                        localStorage.setItem('name', enteredName);

                        $('#overlay').hide();
                        $('#greetingname').text(enteredName);
                        $('.greeting').show();
                        $('#logout').show();
                        location.reload();
                    }
                });
            }

        });


        function addOrder(cocktail) {

            Swal.fire({
                title: 'Bestellung aufgeben',
                html: '<p>Du möchtest folgendes bestellen:</p><b>' + cocktail +'</b><br><br>',
                showCancelButton: true,
                confirmButtonText: 'Weiter',
                confirmButtonColor: 'green',
                cancelButtonText: 'Zurück',
                preConfirm: function() {
                    return new Promise(function(resolve) {
                        const nameInput = localStorage.getItem('name');
                        resolve(nameInput);
                    });
                }
            }).then(function(result) {
                if(result.isConfirmed) {
                    const name = result.value;
                    $.ajax({
                        url: 'ajax.php',
                        type: 'POST',
                        data: {
                            name : name,
                            cocktail : cocktail
                        },
                        dataType: 'json',
                        success: function(data) {
                            Swal.fire({
                                title: 'Vielen Dank!',
                                text: 'Deine Bestellung wird umgehend zubereitet',
                                icon: 'success',
                                confirmButtonText: 'Weiter'
                            })
                        },
                        error: function(request, error) {
                            alert('Fehler')
                        }
                    });
                }
            })

        }

        function myOrders() {

            var summe = 0;

            $.ajax({
                url: 'bestellungen.php',
                type: 'POST',
                data: {
                    name : localStorage.getItem('name')
                },
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(key, element) {
                        summe += element['preis'];
                        console.log(key)
                        console.log(element['anzahl'])
                        console.log(element['preis'])
                        $('.products').append(
                            '<div class="product">'+
                            '<img src="img/Turnbuckle-Cocktail-3.jpg" fill="none" viewBox="0 0 60 60" height="60" width="60" xmlns="http://www.w3.org/2000/svg">'+
                            '<div>'+
                            '<span style="margin-top:22%">'+key+'</span>'+
                    '</div>'+
                        '<div class="quantity">'+
                            '<button>'+
                                '<svg fill="none" viewBox="0 0 24 24" height="14" width="14" xmlns="http://www.w3.org/2000/svg">'+
                                    '<path stroke-linejoin="round" stroke-linecap="round" stroke-width="2.5" stroke="#47484b" d="M20 12L4 12"></path>'+
                                '</svg>'+
                            '</button>'+
                            '<label>'+element["anzahl"]+'</label>'+
                            '<button>'+
                                '<svg fill="none" viewBox="0 0 24 24" height="14" width="14" xmlns="http://www.w3.org/2000/svg">'+
                                    '<path stroke-linejoin="round" stroke-linecap="round" stroke-width="2.5" stroke="#47484b" d="M12 4V20M20 12H4"></path>'+
                                '</svg>'+
                            '</button>'+
                        '</div>'+
                        '<label class="price small" style="margin-top:20%">'+element["preis"]+',00€'+'</label>'+
                    '</div>')
                    });
                    $('.details').append('<span>Gesamt:</span>'+'<span>'+summe+',00€'+'</span>');
                    $('.checkout--footer label').append(summe+',00€')
                    $('#overlay-cart').fadeIn();

                },
                error: function(request, error) {

                }
            });

        }

        function login() {

            var login = localStorage.getItem('login');

            if(login) {
                window.location.href = '/rezepte.html'
            } else {
                $('#login-container').fadeIn();
            }

        }


        function payment() {
            $.ajax({
                url: 'paypal.php',
                type: 'POST',
                data: {
                    act : 'login'
                },
                dataType: 'json',
                success: function(data) {
                    alert(data);
                },
                error: function(request, error) {
                    alert("fehler");
                }
            });
        }

    </script>
</head>
<body>

    <header>
        <span id="login" onclick="login();">Adminbereich</span>
        <div class="menu-btn">
            <div class="btn-line"></div>
            <div class="btn-line"></div>
            <div class="btn-line"></div>
        </div>
        <nav class="menu">
            <ul>
                <li><a href="#">Startseite</a></li>
                <li><a href="#">Über uns</a></li>
                <li><a href="#">Dienstleistungen</a></li>
                <li><a href="#">Kontakt</a></li>
            </ul>
        </nav>
        <span id="headline">Getränkekarte</span>
        <span class="material-symbols-outlined" id="logout">logout</span>
        <span class="material-symbols-outlined" id="shopping-cart" onclick="myOrders();">shopping_cart</span>
        <h3 class="greeting">Hallo, <span id="greetingname"></span></h3>

    </header>

    <div id="main">
        {foreach $cocktails as $key => $cocktail}
            <div class="drink">

                <div class="textbox">
                    <div class="cocktailname">
                        <p id="cocktailname">{$key}</p>
                    </div>
                    <div class="zutaten">
                        {foreach $cocktail.Zutaten as $array}
                            {foreach $array as $zutat}
                                <span id="zutat">{$zutat} | </span>
                            {/foreach}
                        {/foreach}
                        <br>
                    </div>
                    <p id="preis">Preis: {$cocktail.Preis[0]}€</p>
                    <button class="order-btn" data-item="Drink 1" value="{$key}">Bestellen</button>
                </div>

                <div class="img-cocktail">
                    <img src="img/Turnbuckle-Cocktail-3.jpg" alt="Drink 1">
                </div>

            </div>

        {/foreach}

    </div>

    <div id="overlay">
        <div class="subscribe" id="popup">
            <h2>Willkommen in der MakaBar</h2>
            <p>Schön, dass du den Abend mit mir verbringst!</p>
            <img src="img/maddin.jpg"><br>
            <input id="prename" placeholder="Dein Name" class="subscribe-input" name="prename" type="text">
            <br>
            <div id="submit-btn" class="submit-btn">Weiter</div>
        </div>
    </div>

    <div id="overlay-cart">
        <div class="master-container">
            <div class="card cart">
                <br>
                <label class="title-order">Deine Bestellungen</label>
                <div class="products">

                </div>
            </div>

            <div class="card checkout">
                <br>
                <label class="title-checkout">Checkout</label>
                <div class="details">


                </div>
                <div class="checkout--footer">
                    <label class="price"></label>
                    <button id="trash">
                        <span class="material-symbols-outlined" id="delete">Delete</span>
                    </button>
                    <input id="checkout-btn" type="submit" value="Bezahlen" onclick="payment()">

                </div>
            </div>
        </div>
    </div>

    <div id="login-container">
        <div class="card-login">
            <span class="material-symbols-outlined" id="close-login">Close</span>
            <h4 class="title">Log In!</h4>
            <form id="adminForm">
                <div class="field">
                    <svg class="input-icon" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
                        <path d="M207.8 20.73c-93.45 18.32-168.7 93.66-187 187.1c-27.64 140.9 68.65 266.2 199.1 285.1c19.01 2.888 36.17-12.26 36.17-31.49l.0001-.6631c0-15.74-11.44-28.88-26.84-31.24c-84.35-12.98-149.2-86.13-149.2-174.2c0-102.9 88.61-185.5 193.4-175.4c91.54 8.869 158.6 91.25 158.6 183.2l0 16.16c0 22.09-17.94 40.05-40 40.05s-40.01-17.96-40.01-40.05v-120.1c0-8.847-7.161-16.02-16.01-16.02l-31.98 .0036c-7.299 0-13.2 4.992-15.12 11.68c-24.85-12.15-54.24-16.38-86.06-5.106c-38.75 13.73-68.12 48.91-73.72 89.64c-9.483 69.01 43.81 128 110.9 128c26.44 0 50.43-9.544 69.59-24.88c24 31.3 65.23 48.69 109.4 37.49C465.2 369.3 496 324.1 495.1 277.2V256.3C495.1 107.1 361.2-9.332 207.8 20.73zM239.1 304.3c-26.47 0-48-21.56-48-48.05s21.53-48.05 48-48.05s48 21.56 48 48.05S266.5 304.3 239.1 304.3z"></path></svg>
                    <input autocomplete="off" id="logname" placeholder="Name" class="input-field" name="logname" type="text">
                </div>
                <div class="field">
                    <svg class="input-icon" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
                        <path d="M80 192V144C80 64.47 144.5 0 224 0C303.5 0 368 64.47 368 144V192H384C419.3 192 448 220.7 448 256V448C448 483.3 419.3 512 384 512H64C28.65 512 0 483.3 0 448V256C0 220.7 28.65 192 64 192H80zM144 192H304V144C304 99.82 268.2 64 224 64C179.8 64 144 99.82 144 144V192z"></path></svg>
                    <input autocomplete="off" id="logpass" placeholder="Password" class="input-field" name="logpass" type="password">
                </div>
                <input class="btn" id="adminLogin" type="button" value="Login">
                <a href="#" class="btn-link">Forgot your password?</a>
            </form>
        </div>
    </div>
    </script>
</body>
</html>
