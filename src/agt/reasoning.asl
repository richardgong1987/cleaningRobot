// 已知事实
paid(alice).           // Alice 已付款
in_stock(book).       // 书有库存
ordered(alice, book). // Alice 买了书

// 推理规则：已付款 + 所购商品有库存 => 可以配送
can_deliver(Customer) :-
    paid(Customer)
    & ordered(Customer, Item)
    & in_stock(Item).

// 目标：处理 Alice 的订单
!process(alice).

// 能推导出可以配送，则执行这个计划
+!process(Customer) : can_deliver(Customer)
    <- .print("Delivering to ", Customer).

// 无法推导出可以配送，则执行这个计划
+!process(Customer) : not can_deliver(Customer)
    <- .print("Cannot deliver to ", Customer).