<cfcomponent extends="wheelsMapping.test">

	<cffunction name="setup">
		<cfset pkg.controller = controller("dummy")>
		<cfset result = "">
		<cfset results = {}>
		<cfset loc.controller = controller(name="dummy")>
		<cfset loc.args = {}>
		<cfset loc.args.label = false>
	</cffunction>

	<cffunction name="testNoLabels">
		<cfset result = pkg.controller.dateTimeSelectTags(name="theName", label=false)>
		<cfset assert("result Does Not Contain 'label'")>
	</cffunction>

	<cffunction name="testSameLabels">
		<cfset var loc = {}>
		<cfset loc.str = pkg.controller.dateTimeSelectTags(name="theName", label="lblText")>
		<cfset loc.sub = "lblText">
		<cfset result = (Len(loc.str)-Len(Replace(loc.str,loc.sub,"","all")))/Len(loc.sub)>
		<cfset assert("result IS 6")>
	</cffunction>

	<cffunction name="testSplittingLabels">
		<cfset result = pkg.controller.dateTimeSelectTags(name="theName", label="labelMonth,labelDay,labelYear,labelHour,labelMinute,labelSecond")>
		<cfset assert("result Contains 'labelDay' AND result Contains 'labelSecond'")>
	</cffunction>

	<cffunction name="test_dateTimeSelectTags_allow_to_select_blank">
		<cfset loc.args.name = "dateselector">
		<cfset loc.args.includeBlank = "true">
		<cfset loc.args.selected = "">
		<cfset loc.args.startyear = "2000">
		<cfset loc.args.endyear = "1990">
		<cfset loc.r = loc.controller.dateTimeSelectTags(argumentcollection=loc.args)>
		<cfset debug('loc.r', false)>
		<cfset loc.e = '<select id="dateselector-month" name="dateselector($month)"><option value=""></option><option value="1">January</option><option value="2">February</option><option value="3">March</option><option value="4">April</option><option value="5">May</option><option value="6">June</option><option value="7">July</option><option value="8">August</option><option value="9">September</option><option value="10">October</option><option value="11">November</option><option value="12">December</option></select> '>
		<cfset loc.e &= '<select id="dateselector-day" name="dateselector($day)"><option value=""></option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option>'>
		<cfset loc.e &= '<option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option>'>
		<cfset loc.e &= '<option value="31">31</option></select> <select id="dateselector-year" name="dateselector($year)"><option value=""></option><option value="2000">2000</option><option value="1999">1999</option><option value="1998">1998</option><option value="1997">1997</option><option value="1996">1996</option><option value="1995">1995</option><option value="1994">1994</option><option value="1993">1993</option><option value="1992">1992</option><option value="1991">1991</option>'>
		<cfset loc.e &= '<option value="1990">1990</option></select> - <select id="dateselector-hour" name="dateselector($hour)"><option value=""></option><option value="0">0</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option>'>
		<cfset loc.e &= '<option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option></select>:<select id="dateselector-minute" name="dateselector($minute)"><option value=""></option><option value="0">00</option>'>
		<cfset loc.e &= '<option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option><option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option>'>
		<cfset loc.e &= '<option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option><option value="32">32</option><option value="33">33</option><option value="34">34</option>'>
		<cfset loc.e &= '<option value="35">35</option><option value="36">36</option><option value="37">37</option><option value="38">38</option><option value="39">39</option><option value="40">40</option><option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option><option value="45">45</option><option value="46">46</option><option value="47">47</option><option value="48">48</option><option value="49">49</option><option value="50">50</option><option value="51">51</option>'>
		<cfset loc.e &= '<option value="52">52</option><option value="53">53</option><option value="54">54</option><option value="55">55</option><option value="56">56</option><option value="57">57</option><option value="58">58</option><option value="59">59</option></select>:<select id="dateselector-second" name="dateselector($second)"><option value=""></option><option value="0">00</option><option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option>'>
		<cfset loc.e &= '<option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option>'>
		<cfset loc.e &= '<option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option><option value="32">32</option><option value="33">33</option><option value="34">34</option><option value="35">35</option><option value="36">36</option><option value="37">37</option><option value="38">38</option><option value="39">39</option>'>
		<cfset loc.e &= '<option value="40">40</option><option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option><option value="45">45</option><option value="46">46</option><option value="47">47</option><option value="48">48</option><option value="49">49</option><option value="50">50</option><option value="51">51</option><option value="52">52</option><option value="53">53</option><option value="54">54</option><option value="55">55</option><option value="56">56</option><option value="57">57</option><option value="58">58</option><option value="59">59</option></select>'>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

</cfcomponent>