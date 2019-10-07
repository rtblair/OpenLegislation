package gov.nysenate.openleg.processor.hearing;

import gov.nysenate.openleg.model.hearing.PublicHearing;
import gov.nysenate.openleg.model.hearing.PublicHearingCommittee;
import gov.nysenate.openleg.model.hearing.PublicHearingFile;
import gov.nysenate.openleg.model.hearing.PublicHearingId;
import gov.nysenate.openleg.util.PublicHearingTextUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.charset.Charset;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Service
public class PublicHearingParser
{
    private final PublicHearingTextParser textParser;
    private final PublicHearingTitleParser titleParser;
    private final PublicHearingAddressParser addressParser;
    private final PublicHearingDateParser dateTimeParser;
    private final PublicHearingCommitteeParser committeeParser;

    public PublicHearingParser(PublicHearingTextParser textParser,
                               PublicHearingTitleParser titleParser,
                               PublicHearingAddressParser addressParser,
                               PublicHearingDateParser dateTimeParser,
                               PublicHearingCommitteeParser committeeParser) {
        this.textParser = textParser;
        this.titleParser = titleParser;
        this.addressParser = addressParser;
        this.dateTimeParser = dateTimeParser;
        this.committeeParser = committeeParser;
    }

    /**
     * Parses a {@link PublicHearingFile}, extracting a
     * {@link gov.nysenate.openleg.model.hearing.PublicHearing PublicHearing}.
     * @param publicHearingFile
     * @throws IOException
     */
    public PublicHearing parseHearingFile(PublicHearingFile publicHearingFile) throws IOException {
        final List<List<String>> pages = PublicHearingTextUtils.getPages(
                FileUtils.readFileToString(publicHearingFile.getFile(), Charset.defaultCharset()));
        final List<String> firstPage = pages.get(0);

        String title = titleParser.parse(firstPage);
        String address = addressParser.parse(firstPage);
        LocalDate date = dateTimeParser.parseDate(firstPage);
        LocalTime startTime = dateTimeParser.parseStartTime(firstPage);
        LocalTime endTime = dateTimeParser.parseEndTime(firstPage);
        List<PublicHearingCommittee> committees = committeeParser.parse(firstPage);
        String text = textParser.parse(pages);

        PublicHearingId id = new PublicHearingId(publicHearingFile.getFileName());
        PublicHearing publicHearing = new PublicHearing(id, date, text);
        publicHearing.setTitle(title);
        publicHearing.setAddress(address);
        publicHearing.setStartTime(startTime);
        publicHearing.setEndTime(endTime);
        publicHearing.setCommittees(committees);

        LocalDateTime now = LocalDateTime.now();
        publicHearing.setModifiedDateTime(now);
        publicHearing.setPublishedDateTime(now);

        return publicHearing;
    }
}
