<?php (defined('BASEPATH')) OR exit('No direct script access allowed'); ?>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header modal-primary">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
            <button type="button" class="close mr10" onclick="window.print();"><i class="fa fa-print"></i></button>
            <h4 class="modal-title" id="myModalLabel">
                <?= lang('retur_sales').' # '.$retursales->id; ?>
            </h4>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <tbody>
                                <tr>
                                    <td class="col-xs-2"><?= lang('date'); ?></td>
                                    <td class="col-xs-10"><?= $this->izi->hrld($retursales->date); ?></td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2"><?= lang('no_retur'); ?></td>
                                    <td class="col-xs-10"><?= $retursales->no_retur; ?></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered" style="margin-bottom:0;">
                                <thead>
                                    <tr class="active">
                                        <th><?= lang('product'); ?></th>
                                        <th class="col-xs-2"><?= lang('quantity_retur'); ?></th>
                                        <th class="col-xs-2"><?= lang('unit_price'); ?></th>
                                        <th class="col-xs-2"><?= lang('subtotal'); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $tot = 0;
                                    if ($items) {
                                        foreach ($items as $item) {
                                            echo '<tr>';
                                            echo '<td>'.$item->product_name.' ('.$item->product_code.')</td>';
                                            echo '<td class="text-center">'.$this->izi->formatQuantity($item->quantity_retur).'</td>';
                                            echo '<td class="text-right">'.$this->izi->formatMoney($item->cost).'</td>';
                                            echo '<td class="text-right">'.$this->izi->formatMoney($item->quantity_retur*$item->cost).'</td>';
                                            echo '</tr>';
                                            $tot += $item->subtotal;
                                        }
                                    }
                                    ?>
                                </tbody>
                                <thead>
                                    <tr class="active">
                                        <td><?= lang('total'); ?></td>
                                        <td class="col-xs-2"></td>
                                        <td class="col-xs-2"></td>
                                        <td class="col-xs-2 text-right"><?=$this->izi->formatMoney($tot);?></td>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
