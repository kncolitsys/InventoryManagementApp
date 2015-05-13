
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		&times;
	</button>
	<h4 class="modal-title" id="modalLabel">
		Supplier
	</h4>
</div>
<div class="modal-body" style="max-height: 300px; overflow:scroll;">
	<form role="form" id="supplierEditForm">
		<input type="hidden" id="supplierId" name="supplierId">
		<div class="form-group">
			<label for="suppliername">Supplier Name</label>
			<input type="text" class="form-control" id="supplierName" name="supplierName">
		</div>
		<div class="form-group">
			<label for="supplierContact">Contact</label>
			<input type="text" class="form-control" id="supplierContact" name="supplierContact">
		</div>
		<div class="form-group">
			<label for="supplierEmail">Email</label>
			<input type="email" class="form-control" id="supplierEmail" name="supplierEmail">
		</div>
		<div class="form-group">
			<label for="supplierAddress">Address</label>
			<input type="text" class="form-control" id="supplierAddress" name="supplierAddress">
		</div>
		<div class="form-group">
			<label for="supplierAddress2">Address 2</label>
			<input type="text" class="form-control" id="supplierAddress2" name="supplierAddress2">
		</div>
		<div class="form-group">
			<label for="supplierCity">City</label>
			<input type="text" class="form-control" id="supplierCity" name="supplierCity">
		</div>
		<div class="form-group">
			<label for="supplierState">State</label>
			<input type="text" class="form-control" id="supplierState" name="supplierState">
		</div>
		<div class="form-group">
			<label for="supplierZip">Zip</label>
			<input type="text" class="form-control" id="supplierZip" name="supplierZip">
		</div>
		<div class="form-group">
			<label for="supplierPhone">Phone</label>
			<input type="text" class="form-control" id="supplierPhone" name="supplierPhone">
		</div>
		<div class="form-group">
			<label for="supplierAltPhone">Alt Phone</label>
			<input type="text" class="form-control" id="supplierAltPhone" name="supplierAltPhone">
		</div>
		<div class="form-group">
			<label for="supplierNotes">Notes</label>
			<textarea class="form-control" rows="3" name="supplierNotes" id="supplierNotes"></textarea>
		</div>
		<div class="form-group">
			<label for="supplierStatus">Status</label>
			<select class="form-control" id="supplierStatus" name="supplierStatus">
			</select>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">
		Close
	</button>
	<button type="button" class="btn btn-primary" onclick="supplierNS.saveEditSupplier();">
		Save changes
	</button>
</div>


