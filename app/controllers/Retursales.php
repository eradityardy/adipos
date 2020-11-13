<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Retursales extends MY_Controller {

    function __construct() {
        parent::__construct();

        if (!$this->loggedIn) {
            redirect('login');
        }
        if ( ! $this->session->userdata('store_id')) {
            $this->session->set_flashdata('warning', lang("please_select_store"));
            redirect('stores');
        }
        $this->load->library('form_validation');
        $this->load->model('retursales_model');

        $this->digital_file_types = 'zip|pdf|doc|docx|xls|xlsx|jpg|png|gif';

    }

    function index() {
        $this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        $this->data['page_title'] = lang('retur_sales');
        $bc = array(array('link' => '#', 'page' => lang('retur_sales')));
        $meta = array('page_title' => lang('retur_sales'), 'bc' => $bc);
        $this->page_construct('retursales/index', $this->data, $meta);
    }

    function get_retur() {
        if ( ! $this->Admin) {
            $this->session->set_flashdata('error', lang('access_denied'));
            redirect('pos');
        }
        $this->load->library('datatables');
        $this->datatables->select("id, date, customer_name, no_retur, exno_transaksi");
        $this->datatables->from('vw_retursales_master');
        $this->datatables->where('store_id', $this->session->userdata('store_id'));
        $this->datatables->add_column("Actions", "<div class='text-center'><div class='btn-group'><a href='".site_url('retursales/view/$1')."' title='".lang('view_retursales')."' class='tip btn btn-primary btn-xs' data-toggle='ajax-modal'><i class='fa fa-file-text-o'></i></a> <a href='" . site_url('retursales/edit/$1') . "' title='" . lang("edit_retursales") . "' class='tip btn btn-warning btn-xs'><i class='fa fa-edit'></i></a> <a href='" . site_url('purchases/delete/$1') . "' onClick=\"return confirm('" . lang('alert_x_purchase') . "')\" title='" . lang("delete_retursales") . "' class='tip btn btn-danger btn-xs'><i class='fa fa-trash-o'></i></a></div></div>", "id");

        $this->datatables->unset_column('id');
        echo $this->datatables->generate();

    }

    function add_retur() {
        if ( ! $this->session->userdata('store_id')) {
            $this->session->set_flashdata('warning', lang("please_select_store"));
            redirect('stores');
        }
        if ( ! $this->Admin) {
            $this->session->set_flashdata('error', lang('access_denied'));
            redirect('pos');
        }
        $this->form_validation->set_rules('date', lang('date'), 'required');
        $this->form_validation->set_rules('customer_id', lang('customer'), 'required');
        $this->form_validation->set_rules('exno_transaksi', lang('exno_transaksi'), 'required');

        if ($this->form_validation->run() == true) {
            $this->session->set_userdata('remove_spo', 1);
            $this->session->set_flashdata('message', lang('retursales_added'));
            redirect("retursales");

        } else {

            $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $this->data['customers'] = $this->site->getAllCustomers();
            $this->data['no_transaksis'] = $this->site->getAllTransaksi();
            $this->data['sale_item'] = $this->site->getAllSaleitems();
            $this->data['no_retur'] = $this->retursales_model->getNomorretur();
            $this->data['page_title'] = lang('add_retursales');
            $bc = array(array('link' => site_url('products'), 'page' => lang('products')), array('link' => '#', 'page' => lang('add_product')));
            $meta = array('page_title' => lang('add_retursales'), 'bc' => $bc);
            $this->page_construct('retursales/add_retur', $this->data, $meta);

        }
    }

    function save_retur()
    {
        $date = $this->input->post('date');
        $no_retur = $this->input->post('no_retur');
        $customer_id = $this->input->post('customer_id');
        $exno_transaksi = $this->input->post('exno_transaksi');
		$data = array(
            'date' => $date,
            'no_retur' => $no_retur,
            'customer_id' => $customer_id,
            'exno_transaksi'=>$exno_transaksi,
            'store_id'=>'1'
        );
        $result = $this->retursales_model->add_retursalesmaster($data);
    }

    function save_returdetail()
    {
        $retursales_id = $this->input->post('retursales_id');
        $product_id = $this->input->post('product_id');
        $quantity_retur = $this->input->post('quantity_retur');
        $quantity_sales = $this->input->post('quantity_sales');
        $cost = $this->input->post('cost');
        $subtotal = $this->input->post('subtotal');
        $ex_sales_item_id = $this->input->post('ex_sales_item_id');
        $data = array(
            'retursales_id' => $retursales_id,
            'product_id' => $product_id,
            'quantity_retur' => $quantity_retur,
            'quantity_sales' => $quantity_sales,
            'cost' => $cost,
            'subtotal' => $subtotal,
            'ex_sales_item_id' => $ex_sales_item_id,
        );
        $cek = $this->db->query("SELECT * FROM tbl_retursales_items WHERE retursales_id='".$this->input->post('retursales_id')."' AND product_id='".$this->input->post('product_id')."'")->num_rows();
        if ($cek<=0) {
            $result = $this->retursales_model->add_retursalesdetail($data);
            echo $this->tampilhasiltabel();
        }
        else if ($cek==1) {
            $this->tampilkanhasilgagal();
        }
    }

    function tampilkantabel()
    {
        echo $this->tampilhasiltabel();
    }

    function tampilhasiltabel()
    { 
        $retursales_id = $this->retursales_model->getNoretur();
        $data_detail = $this->retursales_model->show_retur_detail($retursales_id)->result_array();
        $output = '';
		foreach ($data_detail as $items) {
			$output .='
				<tr>
                    <td>'.$items['product_id'].'</td>
                    <td>'.$items['cost'].'</td>
                    <td>'.$items['quantity_sales'].'</td>
                    <td>'.$items['quantity_retur'].'</td>
                    <td>'.$items['subtotal'].'</td>
				</tr>
            ';
		}
		return $output;
    }

    function tampilkanhasilgagal()
    {
        echo $this->tampilhasilgagal();
    }

    function tampilhasilgagal()
    { 
        echo "<script>alert('Data Material sudah ada!')</script>";
    }

    function view($id = NULL) {
        if ( ! $this->Admin) {
            $this->session->set_flashdata('error', lang('access_denied'));
            redirect('pos');
        }
        $this->data['retursales'] = $this->retursales_model->getRetursalesByID($id);
        $this->data['items'] = $this->retursales_model->getAllRetursalesItems($id);
        $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
        $this->data['page_title'] = lang('view_retursales');
        $this->load->view($this->theme.'retursales/view_retur', $this->data);

    }

    function edit($id = NULL) {
        if ( ! $this->Admin) {
            $this->session->set_flashdata('error', lang('access_denied'));
            redirect('pos');
        }
        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }

        $this->form_validation->set_rules('date', lang('date'), 'required');

        if ($this->form_validation->run() == true) {
            $total = 0;
            $quantity = "quantity";
            $product_id = "product_id";
            $unit_cost = "cost";
            $i = isset($_POST['product_id']) ? sizeof($_POST['product_id']) : 0;
            for ($r = 0; $r < $i; $r++) {
                $item_id = $_POST['product_id'][$r];
                $item_qty = $_POST['quantity'][$r];
                $item_cost = $_POST['cost'][$r];
                if( $item_id && $item_qty && $unit_cost ) {

                    if(!$this->site->getProductByID($item_id)) {
                        $this->session->set_flashdata('error', $this->lang->line("product_not_found")." ( ".$item_id." ).");
                        redirect('purchases/edit/'.$id);
                    }

                    $products[] = array(
                        'product_id' => $item_id,
                        'cost' => $item_cost,
                        'quantity' => $item_qty,
                        'subtotal' => ($item_cost*$item_qty)
                        );

                    $total += ($item_cost * $item_qty);

                }
            }

            if (!isset($products) || empty($products)) {
                $this->form_validation->set_rules('product', lang("order_items"), 'required');
            } else {
                krsort($products);
            }

            $data = array(
                        'date' => $this->input->post('date'),
                        'reference' => $this->input->post('reference'),
                        'note' => $this->input->post('note', TRUE),
                        'total' => $total
                    );

            if ($_FILES['userfile']['size'] > 0) {

                $this->load->library('upload');
                $config['upload_path'] = 'uploads/';
                $config['allowed_types'] = $this->allowed_types;
                $config['max_size'] = '2000';
                $config['overwrite'] = FALSE;
                $config['encrypt_name'] = TRUE;
                $this->upload->initialize($config);

                if (!$this->upload->do_upload()) {
                    $error = $this->upload->display_errors();
                    $this->upload->set_flashdata('error', $error);
                    redirect("purchases/add");
                }

                $data['attachment'] = $this->upload->file_name;

            }
            // $this->izi->print_arrays($data, $products);
        }

        if ($this->form_validation->run() == true && $this->purchases_model->updatePurchase($id, $data, $products)) {

            $this->session->set_userdata('remove_spo', 1);
            $this->session->set_flashdata('message', lang('purchase_updated'));
            redirect("purchases");

        } else {

            $this->data['purchase'] = $this->purchases_model->getPurchaseByID($id);
            $inv_items = $this->purchases_model->getAllPurchaseItems($id);
            $c = rand(100000, 9999999);
            foreach ($inv_items as $item) {
                $row = $this->site->getProductByID($item->product_id);
                $row->qty = $item->quantity;
                $row->cost = $item->cost;
                $ri = $this->Settings->item_addition ? $row->id : $c;
                $pr[$ri] = array('id' => $ri, 'item_id' => $row->id, 'label' => $row->name . " (" . $row->code . ")", 'row' => $row);
                $c++;
            }

            $this->data['items'] = json_encode($pr);
            $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $this->data['suppliers'] = $this->site->getAllSuppliers();
            $this->data['page_title'] = lang('edit_purchase');
            $bc = array(array('link' => site_url('purchases'), 'page' => lang('purchases')), array('link' => '#', 'page' => lang('edit_purchase')));
            $meta = array('page_title' => lang('edit_purchase'), 'bc' => $bc);
            $this->page_construct('purchases/edit', $this->data, $meta);

        }
    }

    function delete($id = NULL) {
        if(DEMO) {
            $this->session->set_flashdata('error', lang('disabled_in_demo'));
            redirect(isset($_SERVER["HTTP_REFERER"]) ? $_SERVER["HTTP_REFERER"] : 'welcome');
        }

        if($this->input->get('id')){ $id = $this->input->get('id'); }

        if (!$this->Admin) {
            $this->session->set_flashdata('error', lang("access_denied"));
            redirect('sales');
        }

        if ( $this->sales_model->deleteInvoice($id) ) {
            $this->session->set_flashdata('message', lang("invoice_deleted"));
            redirect('sales');
        }

    }

    function delete_holded($id = NULL) {

        if($this->input->get('id')){ $id = $this->input->get('id'); }

        if (!$this->Admin) {
            $this->session->set_flashdata('error', lang("access_denied"));
            redirect('sales/opened');
        }

        if ( $this->sales_model->deleteOpenedSale($id) ) {
            $this->session->set_flashdata('message', lang("opened_bill_deleted"));
            redirect('sales/opened');
        }

    }

    /* -------------------------------------------------------------------------------- */

    function payments($id = NULL) {
        $this->data['payments'] = $this->sales_model->getSalePayments($id);
        $this->load->view($this->theme . 'sales/payments', $this->data);
    }

    function payment_note($id = NULL) {
        $payment = $this->sales_model->getPaymentByID($id);
        $inv = $this->sales_model->getSaleByID($payment->sale_id);
        $this->data['customer'] = $this->site->getCompanyByID($inv->customer_id);
        $this->data['inv'] = $inv;
        $this->data['payment'] = $payment;
        $this->data['page_title'] = $this->lang->line("payment_note");

        $this->load->view($this->theme . 'sales/payment_note', $this->data);
    }

    function add_payment($id = NULL, $cid = NULL) {
        $this->load->helper('security');
        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }

        $this->form_validation->set_rules('amount-paid', lang("amount"), 'required');
        $this->form_validation->set_rules('paid_by', lang("paid_by"), 'required');
        $this->form_validation->set_rules('userfile', lang("attachment"), 'xss_clean');
        if ($this->form_validation->run() == true) {
            if ($this->Admin) {
                $date = $this->input->post('date');
            } else {
                $date = date('Y-m-d H:i:s');
            }
            $payment = array(
                'date' => $date,
                'sale_id' => $id,
                'customer_id' => $cid,
                'reference' => $this->input->post('reference'),
                'amount' => $this->input->post('amount-paid'),
                'paid_by' => $this->input->post('paid_by'),
                'cheque_no' => $this->input->post('cheque_no'),
                'gc_no' => $this->input->post('gift_card_no'),
                'cc_no' => $this->input->post('pcc_no'),
                'cc_holder' => $this->input->post('pcc_holder'),
                'cc_month' => $this->input->post('pcc_month'),
                'cc_year' => $this->input->post('pcc_year'),
                'cc_type' => $this->input->post('pcc_type'),
                'note' => $this->input->post('note'),
                'created_by' => $this->session->userdata('user_id'),
                'store_id' => $this->session->userdata('store_id'),
            );

            if ($_FILES['userfile']['size'] > 0) {
                $this->load->library('upload');
                $config['upload_path'] = 'files/';
                $config['allowed_types'] = $this->digital_file_types;
                $config['max_size'] = 2048;
                $config['overwrite'] = FALSE;
                $config['encrypt_name'] = TRUE;
                $this->upload->initialize($config);
                if (!$this->upload->do_upload()) {
                    $error = $this->upload->display_errors();
                    $this->session->set_flashdata('error', $error);
                    redirect($_SERVER["HTTP_REFERER"]);
                }
                $photo = $this->upload->file_name;
                $payment['attachment'] = $photo;
            }

            // $this->izi->print_arrays($payment);

        } elseif ($this->input->post('add_payment')) {
            $this->session->set_flashdata('error', validation_errors());
            $this->izi->dd();
        }


        if ($this->form_validation->run() == true && $this->sales_model->addPayment($payment)) {
            $this->session->set_flashdata('message', lang("payment_added"));
            redirect($_SERVER["HTTP_REFERER"]);
        } else {

            $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $sale = $this->sales_model->getSaleByID($id);
            $this->data['inv'] = $sale;

            $this->load->view($this->theme . 'sales/add_payment', $this->data);
        }
    }

    function edit_payment($id = NULL, $sid = NULL) {

        if (!$this->Admin) {
            $this->session->set_flashdata('error', lang("access_denied"));
            redirect($_SERVER["HTTP_REFERER"]);
        }
        $this->load->helper('security');
        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }

        $this->form_validation->set_rules('amount-paid', lang("amount"), 'required');
        $this->form_validation->set_rules('paid_by', lang("paid_by"), 'required');
        $this->form_validation->set_rules('userfile', lang("attachment"), 'xss_clean');
        if ($this->form_validation->run() == true) {
            $payment = array(
                'sale_id' => $sid,
                'reference' => $this->input->post('reference'),
                'amount' => $this->input->post('amount-paid'),
                'paid_by' => $this->input->post('paid_by'),
                'cheque_no' => $this->input->post('cheque_no'),
                'gc_no' => $this->input->post('gift_card_no'),
                'cc_no' => $this->input->post('pcc_no'),
                'cc_holder' => $this->input->post('pcc_holder'),
                'cc_month' => $this->input->post('pcc_month'),
                'cc_year' => $this->input->post('pcc_year'),
                'cc_type' => $this->input->post('pcc_type'),
                'note' => $this->input->post('note'),
                'updated_by' => $this->session->userdata('user_id'),
                'updated_at' => date('Y-m-d H:i:s'),
            );

            if ($this->Admin) {
                $payment['date'] = $this->input->post('date');
            }

            if ($_FILES['userfile']['size'] > 0) {
                $this->load->library('upload');
                $config['upload_path'] = 'files/';
                $config['allowed_types'] = $this->digital_file_types;
                $config['max_size'] = 2048;
                $config['overwrite'] = FALSE;
                $config['encrypt_name'] = TRUE;
                $this->upload->initialize($config);
                if (!$this->upload->do_upload()) {
                    $error = $this->upload->display_errors();
                    $this->session->set_flashdata('error', $error);
                    redirect($_SERVER["HTTP_REFERER"]);
                }
                $photo = $this->upload->file_name;
                $payment['attachment'] = $photo;
            }

            //$this->izi->print_arrays($payment);

        } elseif ($this->input->post('edit_payment')) {
            $this->session->set_flashdata('error', validation_errors());
            $this->izi->dd();
        }


        if ($this->form_validation->run() == true && $this->sales_model->updatePayment($id, $payment)) {
            $this->session->set_flashdata('message', lang("payment_updated"));
            redirect("sales");
        } else {

            $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $payment = $this->sales_model->getPaymentByID($id);
            if($payment->paid_by != 'cash') {
                $this->session->set_flashdata('error', lang('only_cash_can_be_edited'));
                $this->izi->dd();
            }
            $this->data['payment'] = $payment;
            $this->load->view($this->theme . 'sales/edit_payment', $this->data);
        }
    }

    function delete_payment($id = NULL) {

        if($this->input->get('id')){ $id = $this->input->get('id'); }

        if (!$this->Admin) {
            $this->session->set_flashdata('error', lang("access_denied"));
            redirect($_SERVER["HTTP_REFERER"]);
        }

        if ( $this->sales_model->deletePayment($id) ) {
            $this->session->set_flashdata('message', lang("payment_deleted"));
            redirect('sales');
        }
    }

    public function status() {
        if ( ! $this->Admin) {
            $this->session->set_flashdata('warning', lang('access_denied'));
            redirect('sales');
        }
        $this->form_validation->set_rules('sale_id', lang('sale_id'), 'required');
        $this->form_validation->set_rules('status', lang('status'), 'required');

        if ($this->form_validation->run() == true) {

            $this->sales_model->updateStatus($this->input->post('sale_id', TRUE), $this->input->post('status', TRUE));
            $this->session->set_flashdata('message', lang('status_updated'));
            redirect('sales');

        } else {

            $this->session->set_flashdata('error', validation_errors());
            redirect('sales');

        }
    }
    
    public function proses() {
        if ( ! $this->Admin) {
            $this->session->set_flashdata('warning', lang('access_denied'));
            redirect('sales');
        }
        $this->form_validation->set_rules('sale_id', lang('sale_id'), 'required');
        $this->form_validation->set_rules('status', lang('status'), 'required');

        if ($this->form_validation->run() == true) {

            $this->sales_model->updatePengiriman($this->input->post('sale_id', TRUE), $this->input->post('status', TRUE));
            $this->session->set_flashdata('message', lang('status_updated'));
            redirect('welcome');

        } else {

            $this->session->set_flashdata('error', validation_errors());
            redirect('welcome');

        }
    }
	
    function add_resi($id = NULL) {
        $this->load->helper('security');
        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }
		$this->form_validation->set_rules('sale_id', lang('sale_id'), 'required');

        if ($this->form_validation->run() == true) {
			$this->sales_model->updatePengiriman($this->input->post('sale_id', TRUE), $this->input->post('resi', TRUE), $this->input->post('kurir', TRUE));
            $this->session->set_flashdata('message', 'Berhasil menambahkan no resi');
            redirect($_SERVER["HTTP_REFERER"]);
        } else {

            $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $sale = $this->sales_model->getSaleByID($id);
            $this->data['inv'] = $sale;

            $this->load->view($this->theme . 'sales/add_resi', $this->data);
        }
    }

}
