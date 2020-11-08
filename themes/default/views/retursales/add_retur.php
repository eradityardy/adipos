<?php (defined('BASEPATH')) OR exit('No direct script access allowed'); ?>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-body">
                    <div class="col-lg-12">
                        <?= form_open_multipart("retursales/add_retur", 'class="validation"');?>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <?= lang('date', 'date'); ?>
                                    <?= form_input('date', set_value('date', date('Y-m-d H:i')), 'class="form-control tip" id="date"  required="required"'); ?>
                                </div>
                                <div class="form-group">
                                    <?= lang('customer', 'customer'); ?>
                                    <?php
                                    $sp[''] = lang("select")." ".lang("customer");
                                    foreach($customers as $customer) {
                                        $sp[$customer->id] = $customer->name;
                                    }
                                    ?>
                                    <?= form_dropdown('customer_id', $sp, set_value('customer_id'), 'class="form-control select2 tip" id="customer"  required="required" style="width:100%;"'); ?>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <?= lang('no_retur', 'no_retur'); ?>
                                    <?= form_input('no_retur', set_value('no_retur', $no_retur), 'class="form-control tip" id="no_retur" required="required"'); ?>
                                </div>
                                <div class="form-group">
                                    <?= lang('exno_transaksi', 'exno_transaksi'); ?>
                                    <select name="exno_transaksi" id="exno_transaksi" class="form-control select2 tip" required>
                                        <option value="">Pilih Nomor Transaksi</option>
                                        <?php                                
                                        foreach ($no_transaksis as $row)
                                        {  
                                            printf("<option value='%s' class='%s'>%s</option>",$row->id,$row->customer_id,$row->id);
                                        }
                                    echo"</select>" ?>
                                </div>
                            </div>

                            <div class="col-md-12">
                                    <table id="sale_items" class="table table-striped table-bordered">
                                        <thead>
                                            <tr class="active">
                                                <th><?= lang('product'); ?></th>
                                                <th class="col-xs-2"><?= lang('unit_price'); ?></th>
                                                <th class="col-xs-2"><?= lang('quantity_sales'); ?></th>
                                                <th class="col-xs-2"><?= lang('quantity_retur'); ?></th>
                                                <th class="col-xs-2"><?= lang('subtotal'); ?></th>
                                            </tr>
                                        </thead>
                                        <tbody id="list_tbody">
                                        </tbody>
                                    </table>
                            </div>

                        </div>
                        <div class="form-group">
                            <?= form_submit('add_retur', lang('add_retur'), 'class="btn btn-primary"'); ?>
                            <button type="button" id="reset" class="btn btn-danger"><?= lang('reset'); ?></button>
                        </div>
                        <?= form_close();?>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    $(document).ready(function() {
        $("#exno_transaksi").change(function() {
            //let a = $(this).val();
            //console.log(a);
            sale_items();
        });

        $("#exno_transaksi").chained("#customer");
    });

    function sale_items() {
        var sale_id = $("#exno_transaksi").val();
        $.ajax({
            url : "<?= base_url('Retursales/load_saleitems') ?>",
            data: "sale_id=" + sale_id,
            success: function(data) {
                //$("#sale_items tbody").html('<tr><td colspan="4" align="center">Tidak ada data</td></tr>')
                //console.log(data);
                $("#list_tbody").html(data);
            }
        });
    }
</script>
<script src="<?= $assets ?>dist/js/jquery.chained.min.js" type="text/javascript"></script>