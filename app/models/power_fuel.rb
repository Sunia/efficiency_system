class PowerFuel < ActiveRecord::Base
  attr_accessible :sea_report_id, :me_power, :hours, :me_rpm, :tc_cut_out, :me_load_mcr,  :me_total_average, :me_sfoc, :properties_lcv_hshfo, :properties_lcv_lshfo, :properties_lcv_hsmdo, :properties_lcv_lsmdo, :properties_sulphur_hshfo,:properties_sulphur_lshfo, :properties_sulphur_hsmdo, :properties_sulphur_lsmdo, :oil_consumers_me_hshfo, :oil_consumers_me_lshfo, :oil_consumers_me_hsmdo, :oil_consumers_me_lsmdo, :oil_consumers_aux_hshfo,:oil_consumers_aux_lshfo, :oil_consumers_aux_hsmdo,:oil_consumers_aux_lsmdo, :oil_consumers_boiler_hshfo,:oil_consumers_boiler_lshfo, :oil_consumers_boiler_hsmdo,:oil_consumers_boiler_lsmdo, :oil_consumers_boiler_sludge,:oil_consumers_total_hshfo, :oil_consumers_total_lshfo, :oil_consumers_total_hsmdo, :oil_consumers_total_lsmdo,:oil_consumers_total_sludge, :generators_aux1_power,:generators_aux1_hours, :generators_aux2_power,:generators_aux2_hours, :generators_aux3_power,:generators_aux3_hours, :generators_aux4_power,:generators_aux4_hours, :generators_total_power,:electrical_consumers_reefers_power, :electrical_consumers_reefers_number,:electrical_consumers_reefer_cargo_power,:electrical_consumers_reefer_cargo_number,:electrical_consumers_aux_power, :electrical_consumers_total_power,:electrical_consumers_ae_sfoc,:electrical_consumers_basic_load

  has_one :sea_report
end


