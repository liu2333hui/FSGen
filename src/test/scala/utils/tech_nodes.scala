package tester

object TechNode {

    def get(tech:String): String = {
		
		//Put the tech library paths here
		tech match {
//commercial
			case "tsmc40" => "/dfs/app/tsmc_icdc/tsmc040/tsmc040_MS_RF_LP/SC/tcbn40lpbwp/Rev200a/Front_End/timing_power_noise/NLDM/tcbn40lpbwp_200a/tcbn40lpbwptc.db"
			case "tsmc40.old" => "/nfs/project/JayMok/power_experiments_xie/fab/t40lp/sc/tcbn40lpbwp/nldm/tcbn40lpbwptc.db"

			case "tsmc28" => "/nfs/project/JayMok/power_experiments_xie/fab/t28hpcp/sc/tcbn28hpcplusbwp30p140_190a/nldm/tcbn28hpcplusbwp30p140tt0p9v25c.db"

//academic		
			case "asap7" => "/nfs/project/JayMok/power_experiments_xie/primitives/techlib/clean/asap7.db"
			case "chip45" => "/nfs/project/JayMok/power_experiments_xie/fab/nangate45/NangateOpenCellLibrary_typical.db"
                        case "sky130" => "/nfs/project/JayMok/power_experiments_xie/primitives/techlib/clean/sky130.db"
			case _     => throw new IllegalArgumentException("Unknown tech type")
		  }
		
	}
	
}

