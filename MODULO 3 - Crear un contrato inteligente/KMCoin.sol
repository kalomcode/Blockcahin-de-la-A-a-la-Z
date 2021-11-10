// KMCoin

// Versión del Compilador
pragma solidity >=0.4.4 <=0.8.10;

contract kmcoin_ico {
    // Número máximo de KMCoins disponibles para venta
    uint256 public max_kmcoins = 1000000;

    // Conversion Rate entre USD y KMCoins
    uint256 public usd_to_kmcoins = 1000;

    // Número total de KMCoins compradas por inversores
    uint256 public total_kmcoins_bought = 0;

    // Mapping que dada la dirección del inversor, devuelve su equite tanto en KMCoins como en USD
    mapping(address => uint256) equity_kmcoins;
    mapping(address => uint256) equity_usd;

    // Comprobar si un inversor puede comprar KMCoins
    modifier can_buy_kmcoins(uint256 usd_invested) {
        require(usd_invested * usd_to_kmcoins + total_kmcoins_bought <= max_kmcoins, 'No hay tantas KMCoins disponibles');
        _;
    }

    // Obtener el balance de KMCoins de un Inversor
    function equity_in_kmcoins(address investor) external view returns(uint){
        return equity_kmcoins[investor];
    }

    // Obtener el balance de USD  de un Inversor
    function equity_in_usd(address investor) external view returns(uint){
        return equity_usd[investor];
    }

    // Comprar KMCoins
    function buy_kmcoins(address investor, uint usd_invested) external 
    can_buy_kmcoins(usd_invested){
        uint kmcoins_bought = usd_invested * usd_to_kmcoins;
        equity_kmcoins[investor] += kmcoins_bought;
        equity_usd[investor] += usd_invested;
        total_kmcoins_bought += kmcoins_bought;
    }

    // Vender KMCoins
    function sell_kmcoins(address investor, uint kmcoins_sold) external {
        equity_kmcoins[investor] -= kmcoins_sold;
        equity_usd[investor] = equity_kmcoins[investor] / usd_to_kmcoins;
        total_kmcoins_bought -= kmcoins_sold;
    }

}
