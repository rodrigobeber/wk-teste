unit USQLs;

interface

const
    SQLInsertPedido =
        'INSERT INTO pedidos (dt_emissao, cd_cliente, vl_total) '+
        'VALUES (:dt_emissao, :cd_cliente, :vl_total)';

    SQLUpdatePedido =
         'UPDATE pedidos SET ' +
         '   vl_total = :vl_total ' +
         'WHERE nr_pedido = :nr_pedido';

    SQLDeletePedido =
         'DELETE FROM pedidos WHERE nr_pedido = :nr_pedido';

    SQLInsertPedidoProduto =
        'INSERT INTO pedidos_produtos (nr_pedido, cd_produto, nr_quantidade, vl_unitario, vl_total) '+
        'VALUES (:nr_pedido, :cd_produto, :nr_quantidade, :vl_unitario, :vl_total)';

    SQLUpdatePedidoProduto =
        'UPDATE pedidos_produtos SET' +
        '   nr_quantidade = :nr_quantidade,' +
        '   vl_unitario = :vl_unitario,'+
        '   vl_total = :vl_total ' +
        'WHERE id = :id';

    SQLDeletePedidoProdutos =
         'DELETE FROM pedidos_produtos WHERE nr_pedido = :nr_pedido';

    SQLDeletePedidoProdutosIn =
        'DELETE from pedidos_produtos WHERE id in (%s)';

implementation

end.
