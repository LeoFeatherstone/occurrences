# converting BD xml files into bdsky. Involves cutting sampling parameter into two

names_xml <- dir(pattern='.+xml')
xml <- lapply(names_xml, function(x) readLines(con=x))
bdsky_xml <- list()

for (i in 1:length(names_xml)){
	bdsky_xml[[i]] <- xml[[i]][1:max(grep(xml[[i]], pattern='map>'))]
	bdsky_xml[[i]] <- c(bdsky_xml[[i]], '<function spec="beast.core.util.Slice" id="one" arg="@samplingProportionPrior.t:BDskyline" index="0" count="1"/>',
	'<function spec="beast.core.util.Slice" id="two" arg="@samplingProportionPrior.t:BDskyline" index="1" count="1"/>')

	bdsky_xml[[i]] <- c(bdsky_xml[[i]], xml[[i]][(1+max(grep(xml[[i]], pattern='map>'))):(grep(xml[[i]], pattern='<parameter id=\\"samplingProportion.t\\:BDskyline\\"')-1)])
	bdsky_xml[[i]] <- c(bdsky_xml[[i]], '<parameter id="samplingProportion.t:BDskyline" lower="0.0" name="stateNode" upper="1.0" dimension="2">0.1</parameter>')
	bdsky_xml[[i]] <- c(bdsky_xml[[i]], xml[[i]][(grep(xml[[i]], pattern='<parameter id="becomeUninfectiousRate.t:BDskyline"')):(grep(xml[[i]], pattern='<distribution id="BirthDeathSkySerial')-1)])

	bdsky_xml[[i]] <- c(bdsky_xml[[i]], '          <distribution id="BirthDeathSkySerial.t:BDskyline"
				spec="beast.evolution.speciation.BirthDeathSkylineModel"
				becomeUninfectiousRate="@becomeUninfectiousRate.t:BDskyline"
				origin="@origin.t:BDskyline"
				reproductiveNumber="@reproductiveNumber.t:BDskyline"
				samplingProportion="@samplingProportion.t:BDskyline" tree="@Tree.t:BDskyline">',
		'<!-- reverse times, where sampling change occurs at 0.075 since the start of the process
			 becaues it is 0.1 time units long, we use the 0.025=0.1minus0.075 -->',
		    '<samplingRateChangeTimes spec="beast.core.parameter.RealParameter" value="0.035 0"/>',
		    '<reverseTimeArrays spec="beast.core.parameter.BooleanParameter" value="false true true false false"/>',
		    '	  </distribution>')
	bdsky_xml[[i]] <- c(bdsky_xml[[i]], xml[[i]][(1+grep(xml[[i]], pattern='<distribution id="BirthDeathSkySerial')):grep(xml[[i]], pattern='</beast>')])

	writeLines(bdsky_xml[[i]], con=gsub(names_xml[i], pattern='BDConst.+', replacement='BDSky.xml'))
}
