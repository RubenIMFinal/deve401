public with sharing class testCallOUt {
    public static void calloutSoap()
    {
        calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
        double x = 1.0;
        double y = 2.0;
        Double result = calculator.doAdd(x, y);
        system.debug(result);
        result = calculator.doSubtract(x, y);
        system.debug(result);
        result = calculator.doMultiply(x, y);
        system.debug(result);
        result = calculator.doDivide(x, y);
        system.debug(result);
    }

    public static void callOutRest()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200)
        {
            system.debug(response.getBody());
        }
    }
}
