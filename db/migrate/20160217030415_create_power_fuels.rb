class CreatePowerFuels < ActiveRecord::Migration
  def change
    create_table :power_fuels do |t|

      # Sea Report ID
      t.integer :sea_report_id

      ##################################
      # # First table of first division
      ##################################

  	  # ME Power (MAin Engine Power)(In Kw)
      t.integer :me_power
      # hours
      t.float :hours
      # ME RPM
      t.float :me_rpm
      # ME TC-cutout
      t.string :tc_cut_out
      # Load in %MCR
      t.integer :me_load_mcr
      # Total/Average in period(KW)
      t.float :me_total_average
      #ME SFOC(g/KWh) @ 40290 (KJ/Kg)
      t.float :me_sfoc

      ##################################
      # Second table of first division(Oil Properties)
      ##################################

  	  
      #LCV KJ/Kg ->  H.S.HFO L.S.HFO H.S.MDO L.S.MDO 
      t.float :properties_lcv_hshfo
      t.float :properties_lcv_lshfo
      t.float :properties_lcv_hsmdo
      t.float :properties_lcv_lsmdo
   
      #Sulphur% ->  H.S.HFO L.S.HFO H.S.MDO L.S.MDO 
      t.float :properties_sulphur_hshfo
      t.float :properties_sulphur_lshfo
      t.float :properties_sulphur_hsmdo
      t.float :properties_sulphur_lsmdo

      ##################################
      # Third table of first division(Oil Consumers)
      ##################################

      # M.E -> H.S.HFO L.S.HFO H.S.MDO L.S.MDO
      t.float :oil_consumers_me_hshfo
      t.float :oil_consumers_me_lshfo
      t.float :oil_consumers_me_hsmdo
      t.float :oil_consumers_me_lsmdo
   
      # Aux Engg. -> H.S.HFO L.S.HFO H.S.MDO L.S.MDO
      t.float :oil_consumers_aux_hshfo
      t.float :oil_consumers_aux_lshfo
      t.float :oil_consumers_aux_hsmdo
      t.float :oil_consumers_aux_lsmdo
   
      #Boiler   -> H.S.HFO L.S.HFO H.S.MDO L.S.MDO SLudge
      t.float :oil_consumers_boiler_hshfo
      t.float :oil_consumers_boiler_lshfo
      t.float :oil_consumers_boiler_hsmdo
      t.float :oil_consumers_boiler_lsmdo
      t.float :oil_consumers_boiler_sludge
   
      # Total
      t.float :oil_consumers_total_hshfo
      t.float :oil_consumers_total_lshfo
      t.float :oil_consumers_total_hsmdo
      t.float :oil_consumers_total_lsmdo
      t.float :oil_consumers_total_sludge

  #*********************************************************************************    
      ##################################
      # First table of second division(Electrical Generators)
      ##################################

      #Aux Eng 1  Power prod., KWh  Run. Hours
      t.integer :generators_aux1_power
      t.float :generators_aux1_hours
   
      #Aux Eng 2  Power prod., KWh  Run. Hours
      t.integer :generators_aux2_power
      t.float :generators_aux2_hours

      #Aux Eng 3  Power prod., KWh  Run. Hours
      t.integer :generators_aux3_power
      t.float :generators_aux3_hours

      #Aux Eng 4  Power prod., KWh  Run. Hours
      t.integer :generators_aux4_power
      t.float :generators_aux4_hours

      # Total of power production
      t.float :generators_total_power

      ##################################
      # Second table of second division(Electrical Consumers)
      ##################################

      #Reefers  -> Power cons., KWh  No. of Reefers
      t.integer :electrical_consumers_reefers_power
      t.integer :electrical_consumers_reefers_number

      #Reefer Cargo Hold -> Power cons., KWh  No. of Reefers
      t.integer :electrical_consumers_reefer_cargo_power
      t.integer :electrical_consumers_reefer_cargo_number
 
      #Auxiliary Blowers -> Power cons., KWh  No. of Reefers
      t.integer :electrical_consumers_aux_power

      #Total power consumption(kWh)  2121
      t.integer :electrical_consumers_total_power
      #AE SFOC(g/kWh)
      t.float :electrical_consumers_ae_sfoc
      #Basic Load at 20°C(kW)
      t.integer :electrical_consumers_basic_load
      #Reference, class average(kW)
      t.integer :electrical_consumers_reference

      t.timestamps null: false
    end
  end
end
