package gov.nysenate.openleg.ingest.parser.lineparser;

import gov.nysenate.openleg.ingest.parser.BillParser;
import gov.nysenate.openleg.model.bill.Bill;
import gov.nysenate.openleg.model.bill.Person;

import java.util.ArrayList;
import java.util.StringTokenizer;

public class CoSponsorLineParser implements LineParser {
	private ArrayList<Person> coSponsors = new ArrayList<Person>();
	
	public void parseLineData(String line, String lineData, BillParser billParser) {
		if (lineData.charAt(0) != '0') {
			String coSponsorsString = lineData.trim();
			
			StringTokenizer st = new StringTokenizer(coSponsorsString, ",");
			while(st.hasMoreTokens()) {
				Person coSponsor = new Person(st.nextToken().trim());
				if(!coSponsors.contains(coSponsor))
					coSponsors.add(coSponsor);
			}
		}
	}

	public void saveData(Bill bill) {
		bill.setCoSponsors(coSponsors);
	}

	public void clear() {
		coSponsors = new ArrayList<Person>();
	}
}
