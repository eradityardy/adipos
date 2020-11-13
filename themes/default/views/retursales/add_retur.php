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
                        <form id="retur_detailform" class="validation">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <?= lang('products', 'products'); ?>
                                        <select name="product_sales" id="product_sales" class="form-control select3 tip" required>
                                            <option value="">Pilih Produk Retur</option>
                                            <?php                                
                                            foreach ($sale_item as $row)
                                            {  
                                                printf("<option value='%s|%s|%s|%s' class='%s'>%s</option>",$row->product_id,$row->real_unit_price,$row->quantity,$row->id,$row->sale_id,$row->product_name);
                                            }
                                        echo"</select>" ?>
                                        <input type="hidden" id="product_id" name="product_id" value="">
                                        <input type="hidden" id="ex_sales_item_id" name="ex_sales_item_id" value="">
                                    </div>                         
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <?= lang('unit_price', 'unit_price'); ?>
                                        <?= form_input('cost', set_value('cost'), 'class="form-control tip" id="cost" readonly'); ?>
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
                                        <input type="number" id="quantity_retur" name="quantity_retur" class="form-control tip" required>
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
                                <button id="submit_returdetail" class="btn btn-success">
                                    Retur
                                </button>
                            </div>
                        </form>

                        <div class="row">
                            <div class="col-md-12">
                                <table id="table_retur" class="table table-striped table-bordered">
                                    <thead>
                                        <tr class="active">
                                            <th><?= lang('product'); ?></th>
                                            <th class="col-xs-2"><?= lang('unit_price'); ?></th>
                                            <th class="col-xs-2"><?= lang('quantity_sales'); ?></th>
                                            <th class="col-xs-2"><?= lang('quantity_retur'); ?></th>
                                            <th class="col-xs-2"><?= lang('subtotal'); ?></th>
                                        </tr>
                                    </thead>
                                    <tbody id="list_retur">
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
        //untuk simpan master Retur
        $("#retur_detail").hide();
        $("#submit_returmaster").click(function(){
            var a = document.getElementById("customer").value;
            var b = document.getElementById("exno_transaksi").value;
            if (a == "")
            {
                alert("Konsumen tidak boleh kosong");
            }
            else if (b == "")
            {
                alert("Nomor Transaksi tidak boleh kosong");
            }
            else if (b != "")
            {
                $.ajax({
                    url: base_url+'retursales/save_retur',
                    method: "POST", 
                    data: $("#retur_masterform").serialize(),
                    success: function(data)
                    {
                        alert("Data berhasil disimpan");
                        $("#retur_detail").show();
                    }
                });
            }
            return false;
        });

        //untuk simpan detail Retur
        $("#table_retur").hide();
        $(document).on('click','#submit_returdetail',function(){
            $("#table_retur").show();
            $.ajax({
                url : base_url+'retursales/save_returdetail', 
                method: "POST", 
                data: $("#retur_detailform").serialize(),
                success: function(data)
                {
                    $('#list_retur').html(data);
                    $('#product_id').val('');
                    $('#ex_sales_item_id').val('');
                    $('#cost').val('');
                    $('#retursales_id').val('');
                    $('#quantity_sales').val('');
                    $('#quantity_retur').val('');
                    $('#subtotal').val('0');
                    alert("Retur berhasil disimpan");
                }
            });
            return false;
        });

        //untuk load list retur item
        $('#list_retur').load(base_url+'retursales/tampilkantabel');

        $("#product_sales").change(function(){
            var dtval = this.value;
            var arval = dtval.split('|');
            var loval = arval[0];
            var idval = arval[1];
            var iaval = arval[2];
            var weval = arval[3];
            $("#product_id").val(loval);
            $("#cost").val(idval);
            $("#quantity_sales").val(iaval);
            $("#ex_sales_item_id").val(weval);
            document.getElementById('retursales_id').value = document.getElementById('no_retur').value;
        });

        $("#quantity_retur").change(function(){
            var qty = this.value;
            var price = parseInt($("#cost").val());
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