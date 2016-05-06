
		<section class="section-finance" >
			<div class="container">
			
				<cfinvoke component="/cfcs/ultra10/specials_by_location" method="modern_standard">
					<cfinvokeargument name="dealer_id" value="#arguments.dealer_id#"/>
					<cfinvokeargument name="assets" value="#arguments.assets#"/>
					<cfinvokeargument name="Get_Nav" value="#Get_Nav#"/>
					<cfinvokeargument name="Get_Phones" value="#Get_Phones#"/>
					<cfinvokeargument name="show_service" value="no"/>
					<cfinvokeargument name="label_service" value=""/>
					<cfinvokeargument name="store_class" value="fin-loc-store-name"/>
					<cfinvokeargument name="address_class" value="fin-loc-address-class"/>
					<cfinvokeargument name="phone_class" value="fin-loc-phone-class"/>
					<cfinvokeargument name="service_btn_class" value="fin-loc-service-btn-class"/>
					<cfinvokeargument name="show_primary_btn" value="yes"/>
				</cfinvoke>
				<br/>

			</div>
		</div>