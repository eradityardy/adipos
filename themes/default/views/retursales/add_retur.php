<?php (defined('BASEPATH')) OR exit('No direct script access allowed'); ?>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-body">
                    <div class="col-lg-12">
                        <form id="retur_masterform" class="validation">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <?= lang('date', 'date'); ?>
                                        <?= form_input('date', set_value('date', date('Y-m-d H:i')), 'class="form-control tip" id="date"  required="required" readonly'); ?>
                                    </div>
                                    <div class="form-group">
                                        <?= lang('no_retur', 'no_retur'); ?>
                                        <?= form_input('no_retur', set_value('no_retur', $no_retur), 'class="form-control tip" id="no_retur" required="required" readonly'); ?>
                                    </div>                                
                                </div>
                                <div class="col-md-6">
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
                            </div>
                            <div class="form-group">
                                <button id="submit_returmaster" class="btn btn-primary">
                                    Simpan
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12" id="retur_detail">
            <div class="box box-success">
                <div class="box-body">
                    <div class="col-lg-12">
                        <?= form_open_multipart("retursales/add_returdetail", 'class="validation"');?>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <?= lang('products', 'products'); ?>
                                    <select name="product_sales" id="product_sales" class="form-control select3 tip" required>
                                        <option value="">Pilih Produk Retur</option>
                                        <?php                                
                                        foreach ($sale_item as $row)
                                        {  
                                            printf("<option value='%s|%s|%s' class='%s'>%s</option>",$row->product_id,$row->real_unit_price,$row->quantity,$row->sale_id,$row->product_name);
                                        }
                                    echo"</select>" ?>
                                </div>                         
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <?= lang('unit_price', 'unit_price'); ?>
                                    <?= form_input('unit_price', set_value('unit_price'), 'class="form-control tip" id="unit_price" readonly'); ?>
                                    <input type="hidden" id="retursales_id" name="retursales_id" value="">
                                </div>                         
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <?= lang('quantity_sales', 'quantity_sales'); ?>
                                    <?= form_input('quantity_sales', set_value('quantity_sales'), 'class="form-control tip" id="quantity_sales" readonly'); ?>
                                </div>                         
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <?= lang('quantity_retur', 'quantity_retur'); ?>
                                    <?= form_input('quantity_retur', set_value('quantity_retur'), 'class="form-control tip" id="quantity_retur" required="required"'); ?>
                                </div>                         
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <?= lang('subtotal', 'subtotal'); ?>
                                    <?= form_input('subtotal', set_value('subtotal', '0'), 'class="form-control tip" id="subtotal" required="required" readonly'); ?>
                                </div>                         
                            </div>
                        </div>

                        <div class="form-group">
                            <?= form_submit('add_retur', 'Retur', 'class="btn btn-success"'); ?>
                        </div>
                        <?= form_close();?>

                        <div class="row">
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
                                        <tbody>
                                        </tbody>
                                    </table>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    $(document).ready(function() {
        $("#retur_detail").hide();
        $("#submit_returmaster").click(function(){
            $.ajax({
                url : "<?= base_url('retursales/save_retur') ?>", 
                type: "POST", 
                data: $("#retur_masterform").serialize(),
                success: function(data)
                {
                    $("#retur_detail").show();
                }
            });
            return false;
        });

        $("#product_sales").change(function(){
            var dtval = this.value;
            var arval = dtval.split('|');
            var idval = arval[1];
            var iaval = arval[2];
            $("#unit_price").val(idval);
            $("#quantity_sales").val(iaval);
        });

        $("#quantity_retur").change(function(){
            var qty = this.value;
            var price = parseInt($("#unit_price").val());
            var qty_jual = parseInt($("#quantity_sales").val());
            if (qty > qty_jual)
            {
                alert("Jumlah Retur Barang tidak boleh melebihi jumlah Jual");
                $('#quantity_retur').val('');
                $("#subtotal").val('0');
            }
            else if (qty <= qty_jual)
            {
                var subtotal = qty*price;
                $("#subtotal").val(subtotal);
            }
        });

        $("#exno_transaksi").chained("#customer");
    });

    $(document).ready(function() {
        $("#product_sales").chained("#exno_transaksi");
    });
</script>
<script src="<?= $assets ?>dist/js/jquery.chained.min.js" type="text/javascript"></script>