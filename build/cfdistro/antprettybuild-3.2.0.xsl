<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="html" indent="yes"/>
 <xsl:preserve-space elements="*"/>

 <!--            -->
 <!-- parameters -->
 <!--            -->

 <xsl:param name="product">Ant Pretty Build</xsl:param>
 <xsl:param name="id">antprettybuild</xsl:param>
 <xsl:param name="version">3.2.0</xsl:param>
 <xsl:param name="date">2008-04-01</xsl:param>
 <xsl:param name="license">Apache License Version 2.0</xsl:param>
 <xsl:param name="author">Charbel BITAR</xsl:param>
 <xsl:param name="copyright">&#169; 2003-2008</xsl:param>
 <xsl:param name="website">http://antprettybuild.sourceforge.net</xsl:param>
 <xsl:param name="archive"><xsl:value-of select="$id"/>-<xsl:value-of select="$version"/>.jar</xsl:param>
 <xsl:param name="code">net.sourceforge.antex.antprettybuild.AntPrettyBuildApplet.class</xsl:param>

 <!-- environment variables if needed -->
 <xsl:param name="PATH"><!--C:\Program Files\Apache\Ant\bin;%PATH%--></xsl:param>
 <xsl:param name="JAVA_HOME"><!--C:\Program Files\Java\jdk1.5.0--></xsl:param>
 <xsl:param name="ANT_HOME"><!--C:\Program Files\Apache\Ant--></xsl:param>

 <xsl:param name="xsl">
  <xsl:call-template name="self">
   <xsl:with-param name="s"><xsl:value-of select="concat(substring(substring-before(translate(substring-after(processing-instruction('xml-stylesheet'),'href='),'\','/'),'.xsl'),2),'.xsl')"/></xsl:with-param>
  </xsl:call-template>
 </xsl:param>

 <xsl:param name="base"><xsl:value-of select="substring(substring-before(translate(substring-after(processing-instruction('xml-stylesheet'),'href='),'\','/'),$xsl),2)"/></xsl:param>

 <xsl:param name="codebase"><xsl:value-of select="$base"/>./</xsl:param>

 <!-- external css and js files if needed -->
 <xsl:param name="css"><!--<xsl:value-of select="$base"/>antprettybuild.css--></xsl:param>
 <xsl:param name="js"><!--<xsl:value-of select="$base"/>antprettybuild.js--></xsl:param>

 <!-- properties -->
 <xsl:param name="showproperties">true</xsl:param>
 <xsl:param name="sortproperties">false</xsl:param>
 <xsl:param name="showpropertydescription">false</xsl:param>
 <xsl:param name="showtargetproperties">true</xsl:param>
 <xsl:param name="showtargetpropertiespath">true</xsl:param>
 <xsl:param name="loadpropertyfiles">true</xsl:param>
 <xsl:param name="allowmodifyproperties">true</xsl:param>
 <xsl:param name="allowaddproperties">true</xsl:param>
 <xsl:param name="expandproperties">true</xsl:param>

 <!-- imports -->
 <xsl:param name="showimports">true</xsl:param>
 <xsl:param name="sortimports">false</xsl:param>

 <!-- taskdefs -->
 <xsl:param name="showtaskdefs">true</xsl:param>
 <xsl:param name="sorttaskdefs">false</xsl:param>

 <!-- targets -->
 <xsl:param name="showtargets">true</xsl:param>
 <xsl:param name="sorttargets">false</xsl:param>
 <xsl:param name="showsubtargets">true</xsl:param>
 <xsl:param name="showtargetdepends">true</xsl:param>
 <xsl:param name="showtargettasks">true</xsl:param>
 <xsl:param name="allowruntargets">true</xsl:param>

 <!-- runant -->
 <xsl:param name="showrunant">true</xsl:param>
 <xsl:param name="showlibblock">true</xsl:param>
 <xsl:param name="showmoreblock">true</xsl:param>
 <xsl:param name="showlogblock">true</xsl:param>

 <!-- source -->
 <xsl:param name="showsource">true</xsl:param>

 <!-- applet -->
 <xsl:param name="showapplet">true</xsl:param>
 <xsl:param name="debugapplet">false</xsl:param>

 <!-- misc -->
 <xsl:param name="checkforupdate">true</xsl:param>

 <!--            -->
 <!-- templates  -->
 <!--            -->

 <xsl:template name="self">
  <xsl:param name="s"/>
  <xsl:choose>
   <xsl:when test="substring-after($s,'/')">
    <xsl:call-template name="self">
     <xsl:with-param name="s"><xsl:value-of select="substring-after($s,'/')"/></xsl:with-param>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$s"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="splitdepends">
  <xsl:param name="depends"/>
  <xsl:choose>
   <xsl:when test="contains($depends,',')">
    <xsl:variable name="target" select="substring-before($depends,',')" />
    <span style="cursor:pointer" title="View" onclick="viewTarget('{$target}', '{$expandproperties}')"><xsl:value-of select="$target"/></span>,
    <xsl:call-template name="splitdepends">
     <xsl:with-param name="depends">
      <xsl:value-of select="substring-after($depends,',')"/>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <span style="cursor:pointer" title="View" onclick="viewTarget('{$depends}', '{$expandproperties}')"><xsl:value-of select="$depends"/></span>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="/">
  <html>
   <xsl:call-template name="head"/>
   <xsl:call-template name="body"/>
  </html>
 </xsl:template>

 <xsl:template name="head">
  <head>
   <xsl:call-template name="title"/>
   <xsl:call-template name="style"/>
   <xsl:call-template name="extstyle"/>
   <xsl:call-template name="script"/>
   <xsl:call-template name="extscript"/>
  </head>
 </xsl:template>

 <xsl:template name="title">
  <title><xsl:value-of select="/project/@name"/> - <xsl:value-of select="$product"/></title>
 </xsl:template>

 <xsl:template name="style">
  <style type="text/css">
   <![CDATA[
   body {background-color:#003366; color:#ffffff}
   table.property {background-color:#003366}
   tr.property {background-color:#336699}
   table.import {background-color:#003366}
   tr.import {background-color:#336699}
   table.taskdef {background-color:#003366}
   tr.taskdef {background-color:#336699}
   table.target {background-color:#003366}
   tr.target {background-color:#336699}
   table.runant {background-color:#003366}
   tr.runant {background-color:#336699}
   span.projectdescription {color:#ffffcc}
   span.propertyname {border:0px; background-color:#003366; color:#ffffff; font-weight:bold}
   span.propertydescription {color:#ffffcc}
   span.resource {color:#ffffcc; font-weight:bold}
   span.url {color:#ffffcc; font-weight:bold}
   span.defaulttarget {color:#ff0000; font-weight:bold}
   span.importfile {color:#ffffff; font-weight:bold}
   span.importoptional {color:#ffffcc}
   span.taskdefclasspath {color:#ffffcc}
   span.taskdefname {color:#ffffcc; font-weight:bold}
   span.taskdefclassname {color:#ffffcc}
   span.taskdefclasspath {color:#ffffcc}
   span.target {color:#ffffcc; font-weight:bold}
   span.targetdescription {color:#ffffcc}
   span.subtarget {color:#ffffff; font-weight:bold}
   span.targetdepends {color:#ffffff}
   span.targettasks {color:#ffccff}
   span.targettasks a {color:#ffccff}
   span.runant {border:0px; background-color:#003366; color:#ffffff; font-weight:bold}
   input.propertyname {border:0px; background-color:#003366; color:#ffffff; font-weight:bold}
   input.propertyvalue {border:0px; background-color:#003366; color:#ffffff}
   input.runant {border:0px; background-color:#003366; color:#ffffff}
   select.runant {border:0px; background-color:#003366; color:#ffffff}
   ]]>
  </style>
 </xsl:template>

 <xsl:template name="extstyle">
  <xsl:if test="$css">
   <link rel="stylesheet" type="text/css" href="{$css}"/>
  </xsl:if>
 </xsl:template>

 <xsl:template name="script">
  <script type="text/javascript" language="Javascript">
   var codeBase = '<xsl:value-of select="$codebase"/>';
   <![CDATA[
   /**
    * AntPrettyBuildApplet global object.
    */
   var antPrettyBuildApplet;

   /**
    * Property rows counter.
    */
   var r = -1;

   /**
    * Property rows.
    */
   var propertyRows = new Array();

   /**
    * Targets.
    */
   var targets = '';

   /**
    * Target order.
    */
   var targetOrder = 0;

   /**
    * Shorthand for getElementById(id).
    */
   function $(id) {
    if (id != undefined) return document.getElementById(id);
   }

   /**
    * Shorthand for document.getElementById(id).value.
    */
   function $F(id) {
    if ($(id) != undefined) return $(id).value;
   }

   /**
    * Swap display of an element.
    */
   function swapDisplay(id) {
    var e = $(id);
    e.style.display = e.style.display == '' ? 'none' : '';
   }

   /**
    * Convert array to joined array.
    */
   function toString(a) {
    if (a != undefined) return a.join('#');
   }

   /**
    * HTML body load.
    */
   function bodyLoad() {
    antPrettyBuildApplet = $('AntPrettyBuildApplet');
    checkForUpdate();
    antPrettyBuildApplet.set('envPath', $F('hiddenpath'));
    antPrettyBuildApplet.set('javaHome', $F('hiddenjavahome'));
    antPrettyBuildApplet.set('antHome', $F('hiddenanthome'));
    antPrettyBuildApplet.invoke('setEnvironment');
    antPrettyBuildApplet.invoke('loadPropertyFiles');
   }

   /**
    * Check for update.
    */
   function checkForUpdate() {
    var website = $F('hiddenwebsite');
    var version = $F('hiddenversion');
    if (website != undefined && version != undefined) {
     var latestVersion = antPrettyBuildApplet.invoke('getLatestVersion', website);
     if (latestVersion != '') {
      if (version < latestVersion) {
       $('spanupdate').innerHTML = '&#160;<a href="' + website + '" target="_blank" style="background:#ffffff; color:#003366">Upgrade to ' + latestVersion + '</a>&#160;';
      }
     }
    }
   }

   /**
    * Set property.
    */
   function setProperty(propertyName, propertyValue) {
    antPrettyBuildApplet.setProperty(propertyName, propertyValue);
   }

   /**
    * Remove property.
    */
   function removeProperty(propertyName) {
    antPrettyBuildApplet.removeProperty(propertyName);
   }

   /**
    * Add property row.
    */
   function addPropertyRow(propertyName, propertyValue) {
    var propertyTable = $('tableproperty');
    var row = propertyTable.insertRow(propertyTable.rows.length);
    r++;
    row.id = 'propertyrow_' + r;
    var cell1 = row.insertCell(0);
    cell1.style.textAlign = 'center';
    var element1;
    if (propertyName != '') {
     element1 = document.createElement('span');
     element1.innerHTML = propertyName;
     element1.value = propertyName;
    } else {
     element1 = document.createElement('input');
     element1.type = 'text';
     element1.size = '50';
     element1.value = propertyName;
     element1.style.textAlign = 'center';
    }
    element1.id = 'propertyname_' + r;  
    element1.className = 'propertyname';
    cell1.appendChild(element1);
    var cell2 = row.insertCell(1);
    var element2 = document.createElement('input');
    element2.type = 'text';
    element2.id = 'propertyvalue_' + r;
    element2.value = propertyValue;
    element2.size = '50';
    element2.className = 'propertyvalue';
    cell2.appendChild(element2);
    var rowNumber = row.id.substring(row.id.indexOf('propertyrow_') + 12);
    propertyRows[rowNumber] = { key: propertyName, value: propertyValue };
    if (propertyName == '') {
     element1.onchange = function() {
      removeProperty(propertyRows[rowNumber].key);
      propertyRows[rowNumber] = { key: element1.value, value: element2.value };
      setProperty(element1.value, element2.value);
     };
    } else {
     element1.onchange = function() {
      element1.value = propertyName;
     };
    }
    element2.onchange = function() {
     removeProperty(propertyRows[rowNumber].key);
     propertyRows[rowNumber] = { key: element1.value, value: element2.value };
     setProperty(element1.value, element2.value);
    };
    element2.onmouseover = function() {
     element2.title = expandPropertyValue(element2.value);
    };
    try {
     if (propertyTable.rows[0].cells.length > 3) {
      var cell3 = row.insertCell(2);
      var element3 = document.createTextNode(' ');
      cell3.appendChild(element3);
     }
    }
    catch(e) {
     // ignore
    }
    var cell4 = row.insertCell(2);
    var element4 = document.createElement('input');
    element4.type = 'button';
    element4.id = 'buttonremoveproperty_' + r;
    element4.value = 'x';
    element4.title = 'Remove';
    element4.onclick = function() {
     removePropertyRow(row.id);
    };
    if (propertyName != '') element4.disabled = 'true';
    cell4.appendChild(element4);
    try {
     element1.focus();
    }
    catch(e) {
     // ignore
    }
   }

   /**
    * Remove property row.
    */
   function removePropertyRow(rowId) {
    var rowNumber = rowId.substring(rowId.indexOf('propertyrow_') + 12);
    if (propertyRows[rowNumber] != undefined) {
     removeProperty(propertyRows[rowNumber].key);
     propertyRows[rowNumber] = undefined;
    }
    $('tableproperty').deleteRow($(rowId).rowIndex);
   }

   /**
    * Reset properties.
    */
   function resetProperties() {
    for (var i = 0; i < r + 1; i++) {
     if (propertyRows[i] != undefined) removePropertyRow('propertyrow_' + i);
    }
    antPrettyBuildApplet.set('antPropertyFile', '');
    antPrettyBuildApplet.invoke('resetProperties');
    antPrettyBuildApplet.invoke('loadPropertyFiles');
   }

   /**
    * Browse property file.
    */
   function browsePropertyFile(that) {
    var resourceId = 'resource_' + that.id.substring(that.id.indexOf('buttonbrowseresource_') + 21);
    var browseFileValue = antPrettyBuildApplet.invoke('browseFile', '0');
    $(resourceId).value = browseFileValue != undefined ? browseFileValue : $(resourceId).value; 
    antPrettyBuildApplet.set('antPropertyFile', $(resourceId).value);
    loadPropertyFile($(resourceId).value);
   }

   /**
    * Load single property file.
    */
   function loadPropertyFile(propertyFile) {
    antPrettyBuildApplet.invoke('loadPropertyFile', propertyFile);
   }

   /**
    * Change property file.
    */
   function changePropertyFile(propertyFile) {
    resetProperties();
    loadPropertyFile(propertyFile);
   }

   /**
    * Swap property value.
    */
   function swapPropertyValue(propertyName) {
    var v = $F('property_' + propertyName);
    var t = ['true', 'on', 'yes'];
    var f = ['false', 'off', 'no'];
    for (var i = 0; i < 3; i++) {
     if (v == t[i]) $('property_' + propertyName).value = f[i];
     if (v == f[i]) $('property_' + propertyName).value = t[i];
    }
    setProperty(propertyName, $F('property_' + propertyName));
   }

   /**
    * Expand property value.
    */
   function expandPropertyValue(value) {
    var expandedPropertyValue = antPrettyBuildApplet.invoke('expandPropertyValue', value);
    var j = 0;
    while (expandedPropertyValue.indexOf('${') != -1 && j < 10) {
     expandedPropertyValue = antPrettyBuildApplet.invoke('expandPropertyValue', expandedPropertyValue);
     j++;
    }
    if (expandedPropertyValue != null) {
     return(expandedPropertyValue);
    } else {
     return(value);
    }
   }

   /**
    * Swap target select.
    */
   function swapTargetSelect(targetName) {
    if ($('checkboxtarget_' + targetName).checked) {
     targets += ' ' + targetName;
     targetOrder++;
     $('buttontarget_' + targetName).value = targetOrder;
    } else {
     var pattern = ' ' + targetName;
     var reg = new RegExp(pattern, 'g');
     targets = targets.replace(reg, '');
     for (var i = 0; i < $('formtarget').elements.length; i++) {
      var e = $('formtarget').elements[i];
      if (e.type == 'button' && parseInt(e.value, 10) > parseInt($F('buttontarget_' + targetName), 10)) {
       e.value--;
      }
     }
     targetOrder--;
     $('buttontarget_' + targetName).value = '';
    }
   }

   /**
    * View target source.
    */
   function viewTarget(targetName, expandProperties) {
    var tempFileName = antPrettyBuildApplet.invoke('getXMLFragmentFileName', targetName);
    if (tempFileName != null) {
     window.open('file://' + tempFileName, 'windowview', 'width=300px, height=200px, resizable=yes, scrollbars=yes, toolbar=no, menubar=no, location=no, status=no, directories=no');
    }
   }

   /**
    * View source.
    */
   function viewSource() {
    var tempFileName = antPrettyBuildApplet.invoke('getXMLFragmentFileName', 'null');
    if (tempFileName != null) {
     window.open('file://' + tempFileName, 'windowview', 'width=600px, height=400px, resizable=yes, scrollbars=yes, toolbar=no, menubar=no, location=no, status=no, directories=no');
    }
   }

   /**
    * Browse lib directory.
    */
   function browseLibDirectory(that) {
    var browseFileValue = antPrettyBuildApplet.invoke('browseFile', '1');
    $('textlib').value = browseFileValue != undefined ? browseFileValue : $('textlib').value;
   }

   /**
    * Get URL of task documentation from online Ant manual.
    */
   function getAntTaskManualURL(taskName) {
    var taskManualURL = antPrettyBuildApplet.invoke('getAntTaskManualURL', taskName);
    if (taskManualURL != null) {
     window.open(taskManualURL, 'windowview', 'width=600px, height=400px, resizable=yes, scrollbars=yes, toolbar=no, menubar=no, location=no, status=no, directories=no');
    }
   }

   /**
    * On build successful event.
    */
   function onBuildSuccessful() {
    document.body.style.backgroundColor = 'green';
   }

   /**
    * On build failed event.
    */
   function onBuildFailed() {
    document.body.style.backgroundColor = 'red';
   }

   /**
    * Run Ant targets.
    */
   function runAnt(targets) {
    var lib = ($('textlib') != undefined && $F('textlib') != '') ? $F('textlib') : '';
    var logger = ($('selectlogger') != undefined && $F('selectlogger') != '') ? $F('selectlogger') : '';
    var logfile = ($('textlogfile') != undefined && $F('textlogfile') != '') ? $F('textlogfile') : '';
    var mode = ($('selectmode') != undefined && $F('selectmode') != '') ? $F('selectmode') : '';
    var more = ($('textmore') != undefined && $F('textmore') != '') ? $F('textmore') : '';
    targets = targets.replace(/^\s*|\s*$/, '');
    antPrettyBuildApplet.set('antLib', lib);
    antPrettyBuildApplet.set('antLogger', logger);
    antPrettyBuildApplet.set('antLogFile', logfile);
    antPrettyBuildApplet.set('antMode', mode);
    antPrettyBuildApplet.set('antMore', more);
    antPrettyBuildApplet.set('antTargets', targets);
    antPrettyBuildApplet.invoke('execute');
   }
   ]]>
  </script>
 </xsl:template>

 <xsl:template name="extscript">
  <xsl:if test="$js">
   <script type="text/javascript" language="Javascript" src="{$js}" defer="defer"></script>
  </xsl:if>
 </xsl:template>

 <xsl:template name="body">
  <body onload="if (typeof bodyLoad == 'function') bodyLoad()">
   <xsl:call-template name="header"/>
   <xsl:call-template name="main"/>
   <xsl:call-template name="footer"/>
  </body>
 </xsl:template>

 <xsl:template name="header">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; text-align:center">
   <tr>
    <td width="20%"><hr/></td>
    <td width="60%"><hr/></td>
    <td width="20%"><hr/></td>
   </tr>
   <tr>
    <td width="20%"><!-- ASCII Art by Conor MacNeill --><pre>\_/<br/>\(_)/<br/>-(_)-<br/>/(_)\</pre></td>
    <td width="60%"><xsl:call-template name="projects"/></td>
    <td width="20%"><!-- ASCII Art by Conor MacNeill --><pre>\_/<br/>\(_)/<br/>-(_)-<br/>/(_)\</pre></td>
   </tr>
   <tr>
    <td width="20%"><hr/></td>
    <td width="60%"><hr/></td>
    <td width="20%"><hr/></td>
   </tr>
  </table>
 </xsl:template>

 <xsl:template name="main">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <xsl:if test="$showproperties='true'">
    <tr>
     <td><xsl:call-template name="properties"/></td>
    </tr>
    <tr>
     <td>&#160;</td>
    </tr>
   </xsl:if>
   <xsl:if test="$showimports='true'">
    <tr>
     <td><xsl:call-template name="imports"/></td>
    </tr>
    <tr>
     <td>&#160;</td>
    </tr>
   </xsl:if>
   <xsl:if test="$showtaskdefs='true'">
    <tr>
     <td><xsl:call-template name="taskdefs"/></td>
    </tr>
    <tr>
     <td>&#160;</td>
    </tr>
   </xsl:if>
   <xsl:if test="$showtargets='true'">
    <tr>
     <td><xsl:call-template name="targets"/></td>
    </tr>
    <tr>
     <td>&#160;</td>
    </tr>
   </xsl:if>
   <xsl:if test="$showrunant='true'">
    <tr>
     <td><xsl:call-template name="runant"/></td>
    </tr>
    <tr>
     <td>&#160;</td>
    </tr>
   </xsl:if>
   <xsl:if test="$showsource='true'">
    <tr>
     <td><xsl:call-template name="source"/></td>
    </tr>
    <tr>
     <td>&#160;</td>
    </tr>
   </xsl:if>
   <xsl:if test="$showapplet='true'">
    <tr>
     <td><xsl:call-template name="applet"/></td>
    </tr>
    <tr>
     <td>&#160;</td>
    </tr>
   </xsl:if>
  </table>
 </xsl:template>

 <xsl:template name="footer">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; text-align:center">
   <tr>
    <td><hr/></td>
   </tr>
   <tr>
    <td><h5><i>Powered by <a href="{$website}" target="_blank" style="color:inherit; color:#ffffff; text-decoration:none"><xsl:value-of select="$product"/>&#160;<xsl:value-of select="$version"/></a><span id="spanupdate"></span>, <xsl:value-of select="$copyright"/>&#160;<xsl:value-of select="$author"/>. All rights reserved.</i></h5></td>
    <xsl:if test="$checkforupdate='true'">
     <input id="hiddenwebsite" type="hidden" value="{$website}"/>
     <input id="hiddenversion" type="hidden" value="{$version}"/>
    </xsl:if>
   </tr>
  </table>
 </xsl:template>

 <xsl:template name="projects">
  <xsl:apply-templates select="project" mode="project"/>
 </xsl:template>

 <xsl:template name="properties">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <tbody>
    <tr>
     <th align="center" nowrap="nowrap"><span style="cursor:pointer" onclick="swapDisplay('trproperty')"><b>Properties</b></span></th>
    </tr>
    <tr id="trproperty" style="display:none">
     <td>
      <form id="formproperty">
       <table id="tableproperty" border="1" cellspacing="0" style="margin:0 auto" class="property">
        <tr style="padding:3px" class="property">
         <th align="center" style="padding:3px" nowrap="nowrap">Property</th>
         <th align="center" style="padding:3px" nowrap="nowrap">Value</th>
         <xsl:if test="$showpropertydescription='true'">
          <th align="center" style="padding:3px" nowrap="nowrap">Description</th>
         </xsl:if>
         <xsl:if test="$allowmodifyproperties='true'">
          <th align="center" nowrap="nowrap"><input id="buttonreset" type="button" value="0" title="Reset" onclick="$('formproperty').reset(); resetProperties()"/></th>
         </xsl:if>
        </tr>
        <xsl:choose>
         <xsl:when test="$sortproperties='true'">
          <xsl:choose>
           <xsl:when test="$showtargetproperties='true'">
            <xsl:apply-templates select="project//property" mode="property">
             <xsl:sort select="@name"/>
            </xsl:apply-templates>
           </xsl:when>
           <xsl:otherwise>
            <xsl:apply-templates select="project/property" mode="property">
             <xsl:sort select="@name"/>
            </xsl:apply-templates>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
          <xsl:choose>
           <xsl:when test="$showtargetproperties='true'">
            <xsl:apply-templates select="project//property" mode="property"/>
           </xsl:when>
           <xsl:otherwise>
            <xsl:apply-templates select="project/property" mode="property"/>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$allowmodifyproperties='true' and $allowaddproperties='true'">
         <tr class="property">
          <xsl:choose>
           <xsl:when test="$showpropertydescription='true'">
            <th colspan="3" align="center" style="padding:3px" nowrap="nowrap">File/User Properties</th>
           </xsl:when>
           <xsl:otherwise>
            <th colspan="2" align="center" style="padding:3px" nowrap="nowrap">File/User Properties</th>
           </xsl:otherwise>
          </xsl:choose>
          <th><input id="buttonaddproperty" type="button" value="+" title="Add" onclick="addPropertyRow('', '')"/></th>
         </tr>
        </xsl:if>
       </table>
      </form>
     </td>
    </tr>
   </tbody>
  </table>
 </xsl:template>

 <xsl:template name="imports">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <tbody>
    <tr>
     <th align="center" nowrap="nowrap"><span style="cursor:pointer" onclick="swapDisplay('trimport')"><b>Imports</b></span></th>
    </tr>
    <tr id="trimport" style="display:none">
     <td>
      <form id="formimport">
       <table id="tableimport" border="1" cellpadding="0" cellspacing="0" style="margin:0 auto" class="import">
        <tr style="padding:3px" class="import">
         <th align="center" style="padding:3px" nowrap="nowrap">File</th>
         <th align="center" style="padding:3px" nowrap="nowrap">Optional</th>
         <th align="center" style="padding:3px" nowrap="nowrap">&#160;</th>
        </tr>
        <xsl:choose>
         <xsl:when test="$sortimports='true'">
          <xsl:apply-templates select="project/import" mode="import">
           <xsl:sort select="@file"/>
          </xsl:apply-templates>
         </xsl:when>
         <xsl:otherwise>
          <xsl:apply-templates select="project/import" mode="import"/>
         </xsl:otherwise>
        </xsl:choose>
       </table>
      </form>
     </td>
    </tr>
   </tbody>
  </table>
 </xsl:template>

 <xsl:template name="taskdefs">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <tbody>
    <tr>
     <th align="center" nowrap="nowrap"><span style="cursor:pointer" onclick="swapDisplay('trtaskdef')"><b>Taskdefs</b></span></th>
    </tr>
    <tr id="trtaskdef" style="display:none">
     <td>
      <form id="formtaskdef">
       <table id="tabletaskdef" border="1" cellpadding="0" cellspacing="0" style="margin:0 auto" class="taskdef">
        <tr style="padding:3px" class="taskdef">
         <th align="center" style="padding:3px" nowrap="nowrap">Taskdef</th>
         <th align="center" style="padding:3px" nowrap="nowrap">Classname/File/Resource</th>
         <th align="center" style="padding:3px" nowrap="nowrap">Classpath/Classpathref</th>
        </tr>
        <xsl:choose>
         <xsl:when test="$sorttaskdefs='true'">
          <xsl:apply-templates select="project/taskdef" mode="taskdef">
           <xsl:sort select="@name"/>
          </xsl:apply-templates>
         </xsl:when>
         <xsl:otherwise>
          <xsl:apply-templates select="project/taskdef" mode="taskdef"/>
         </xsl:otherwise>
        </xsl:choose>
       </table>
      </form>
     </td>
    </tr>
   </tbody>
  </table>
 </xsl:template>

 <xsl:template name="targets">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <tbody>
    <tr>
     <th align="center" nowrap="nowrap"><span style="cursor:pointer" onclick="swapDisplay('trtarget')"><b>Targets</b></span></th>
    </tr>
    <tr id="trtarget" style="display:none">
     <td>
      <form id="formtarget">
       <table id="tabletarget" border="1" cellpadding="0" cellspacing="0" style="margin:0 auto" class="target">
        <tr style="padding:3px" class="target">
         <xsl:if test="$allowruntargets='true'">
          <th align="center" nowrap="nowrap">&#160;</th>
          <th align="center" nowrap="nowrap">&#160;&#160;&#160;&#160;</th>
         </xsl:if>
         <th align="center" style="padding:3px" nowrap="nowrap">Target</th>
         <th align="center" style="padding:3px" nowrap="nowrap">Description</th>
         <xsl:if test="$showtargetdepends='true'">
          <th align="center" style="padding:3px" nowrap="nowrap">Depends</th>
         </xsl:if>
         <xsl:if test="$showtargettasks='true'">
          <th align="center" style="padding:3px" nowrap="nowrap">Tasks</th>
         </xsl:if>
        </tr>
        <xsl:choose>
         <xsl:when test="$sorttargets='true'">
          <xsl:apply-templates select="project/target" mode="target">
           <xsl:sort select="@name"/>
          </xsl:apply-templates>
         </xsl:when>
         <xsl:otherwise>
          <xsl:apply-templates select="project/target" mode="target"/>
         </xsl:otherwise>
        </xsl:choose>
       </table>
      </form>
     </td>
    </tr>
   </tbody>
  </table>
 </xsl:template>

 <xsl:template name="runant">
  <input id="hiddenpath" type="hidden" value="{$PATH}"/>
  <input id="hiddenjavahome" type="hidden" value="{$JAVA_HOME}"/>
  <input id="hiddenanthome" type="hidden" value="{$ANT_HOME}"/>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <tbody>
    <tr>
     <th align="center" nowrap="nowrap"><span style="cursor:pointer" onclick="swapDisplay('trrunant')"><b>Run</b></span></th>
    </tr>
    <tr id="trrunant" style="display:none">
     <td>
      <form id="formrunant">
       <table id="tablerunant" border="1" cellspacing="0" style="margin:0 auto" class="runant">
        <xsl:if test="$showlibblock='true'">
         <tr>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <span class="runant">Lib</span>
          </td>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <input id="textlib" type="text" size="50" class="runant" value=""/>
          </td>
          <td>
           <input id="buttonbrowselib" type="button" value="~" title="Browse" onclick="browseLibDirectory(this)"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="$showmoreblock='true'">
         <tr>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <span class="runant">More</span>
          </td>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <input id="textmore" type="text" size="50" class="runant" value=""/>
          </td>
          <td>&#160;</td>
         </tr>
        </xsl:if>
        <xsl:if test="$showlogblock='true'">
         <tr>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <span class="runant">Logger</span>
          </td>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <select id="selectlogger" class="runant" style="width:100%">
            <option value="" selected="selected">DefaultLogger</option>
            <option value="NoBannerLogger">NoBannerLogger</option>
            <option value="TimestampedLogger">TimestampedLogger</option>
            <option value="XmlLogger">XmlLogger</option>
           </select>
          </td>
          <td>&#160;</td>
         </tr>
         <tr>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <span class="runant">Log File</span>
          </td>
          <td align="center" style="padding:3px" nowrap="nowrap">
           <input id="textlogfile" type="text" size="50" class="runant" value=""/>
          </td>
          <td>
           <input id="buttonlogfile" type="button" value="?" title="View" onclick="window.open($('textlogfile').value, 'windowlogfile', 'toolbar=no, menubar=no, location=no, status=no, directories=no, resizable=yes, scrollbars=yes')"/>
          </td>
         </tr>
        </xsl:if>
        <tr>
         <td align="center" style="padding:3px" nowrap="nowrap">
          <span class="runant">Mode</span>
         </td>
         <td align="center" style="padding:3px" nowrap="nowrap">
          <select id="selectmode" class="runant" style="width:100%">
           <option value="" selected="selected">Default</option>
           <option value="quiet">Quiet</option>
           <option value="verbose">Verbose</option>
           <option value="debug">Debug</option>
           <option value="emacs">Emacs</option>
          </select>
         </td>
         <td>&#160;</td>
        </tr>
        <tr>
         <td>&#160;</td>
         <td align="center" style="padding:3px" nowrap="nowrap">
          <input id="buttonrunant" type="button" value="- Run -" title="Run" onclick="runAnt(targets)"/>
         </td>
         <td>&#160;</td>
        </tr>
       </table>
      </form>
     </td>
    </tr>
   </tbody>
  </table>
 </xsl:template>

 <xsl:template name="source">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <tbody>
    <tr>
     <th align="center" nowrap="nowrap"><span style="cursor:pointer" onclick="viewSource()"><b>Source</b></span></th>
    </tr>
   </tbody>
  </table>
 </xsl:template>

 <xsl:template name="applet">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto; border-collapse:collapse; text-align:center">
   <tbody>
    <tr>
     <td>
      <applet id="AntPrettyBuildApplet" name="AntPrettyBuildApplet" codebase="{$codebase}" archive="{$archive}" code="{$code}" width="1" height="1" mayscript="mayscript">
       <param name="debug" value="{$debugapplet}"/>
      </applet>
     </td>
    </tr>
   </tbody>
  </table>
 </xsl:template>

 <!--                -->
 <!-- build elements -->
 <!--                -->

 <xsl:template name="project" match="project" mode="project">
  <p>
   <b>Project&#160;Name:</b>&#160;<xsl:value-of select="@name"/>
  </p>
  <xsl:if test="description">
   <p>
    <b>Project&#160;Description:</b><br/>
    <span class="projectdescription"><xsl:value-of select="description"/></span>
   </p>
  </xsl:if>
  <xsl:if test="@basedir">
   <p>
    <b>Project&#160;Basedir:</b>&#160;<xsl:value-of select="@basedir"/>
   </p>
  </xsl:if>
  <p>
   <b>Default&#160;target:</b>&#160;<span class="defaulttarget" style="cursor:pointer" title="View" onclick="viewTarget('{@default}', '{$expandproperties}')"><xsl:value-of select="@default"/></span>
  </p>
 </xsl:template>

 <xsl:template name="property" match="property" mode="property">
  <xsl:choose>
   <xsl:when test="@name">
    <tr>
     <td align="center" style="padding:3px" nowrap="nowrap">
      <xsl:if test="$showtargetproperties='true' and $showtargetpropertiespath='true' and name(..)='target'">
       <xsl:value-of select="../@name"/>&#160;/&#160;
      </xsl:if>
      <span class="propertyname"><xsl:value-of select="@name"/></span>
     </td>
     <xsl:if test="@value|@location|@refid">
      <td>
       <input id="property_{@name}" type="text" size="50" value="{@value|@location|@refid}" class="propertyvalue" onchange="setProperty('{@name}', this.value)" onmouseover="this.title = expandPropertyValue(this.value)">
        <xsl:if test="$allowmodifyproperties!='true'">
         <xsl:attribute name="readonly">readonly</xsl:attribute>
        </xsl:if>
       </input>
      </td>
     </xsl:if>
     <xsl:if test="$showpropertydescription='true'">
      <xsl:choose>
       <xsl:when test="@description and @description!=''">
        <td><span class="propertydescription"><xsl:value-of select="@description"/></span></td>
       </xsl:when>
       <xsl:otherwise>
        <td>&#160;</td>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:if>
     <xsl:if test="$allowmodifyproperties='true'">
      <td>
       <xsl:choose>
        <xsl:when test="@value='true' or @value='on' or @value='yes' or @value='false' or @value='off' or @value='no'">
         <input id="buttonswappropertyvalue_{@name}" type="button" value="!" title="Swap" onclick="swapPropertyValue('{@name}')"/>
        </xsl:when>
        <xsl:otherwise>
         &#160;
        </xsl:otherwise>
       </xsl:choose>
      </td>
     </xsl:if>
    </tr>
   </xsl:when>
   <xsl:otherwise>
    <xsl:if test="@resource|@file">
     <tr>
      <td align="center" style="padding:3px" nowrap="nowrap"><span class="resource" style="cursor:pointer" title="View" onclick="window.open(expandPropertyValue($('resource_{position()}').value))"><xsl:value-of select="name(@*[position()=1])"/></span></td>
      <td>
       <input id="resource_{position()}" type="text" size="50" value="{@resource|@file}" class="propertyvalue" onchange="changePropertyFile(this.value)" onmouseover="this.title = expandPropertyValue(this.value)">
        <xsl:if test="$allowmodifyproperties!='true'">
         <xsl:attribute name="readonly">readonly</xsl:attribute>
        </xsl:if>
       </input>
      </td>
      <xsl:if test="$showpropertydescription='true'">
       <xsl:choose>
        <xsl:when test="@description and @description!=''">
         <td><span class="propertydescription"><xsl:value-of select="@description"/></span></td>
        </xsl:when>
        <xsl:otherwise>
         <td>&#160;</td>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:if>
      <xsl:if test="$allowmodifyproperties='true'">
       <td>
        <input id="buttonbrowseresource_{position()}" type="button" value="~" title="Browse" onclick="browsePropertyFile(this)"/>
       </td>
      </xsl:if>
     </tr>
    </xsl:if>
    <xsl:if test="@url">
     <tr>
      <td align="center" style="padding:3px; cursor:pointer" nowrap="nowrap" title="View" onclick="window.open($('url_{position()}').value)"><span class="url"><xsl:value-of select="name(@*[position()=1])"/></span></td>
      <td>
       <input id="url_{position()}" type="text" size="50" value="{@url}" class="propertyvalue" onchange="setProperty('{@name}', this.value)" onmouseover="this.title = expandPropertyValue(this.value)">
        <xsl:if test="$allowmodifyproperties!='true'">
         <xsl:attribute name="readonly">readonly</xsl:attribute>
        </xsl:if>
       </input>
      </td>
      <xsl:if test="$showpropertydescription='true'">
       <xsl:choose>
        <xsl:when test="@description and @description!=''">
         <td><span class="propertydescription"><xsl:value-of select="@description"/></span></td>
        </xsl:when>
        <xsl:otherwise>
         <td>&#160;</td>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:if>
      <xsl:if test="$allowmodifyproperties='true'">
       <td>&#160;</td>
      </xsl:if>
     </tr>
    </xsl:if>
    <xsl:if test="@environment|@classpath|@classpathref|@prefix">
     <tr>
      <td align="center" style="padding:3px" nowrap="nowrap"><span class="propertyname"><xsl:value-of select="name(@*[position()=1])"/></span></td>
      <td>
       <input id="{name(@*[position()=1])}_{position()}" type="text" size="50" value="{@environment|@classpath|@classpathref|@prefix}" class="propertyvalue" onchange="setProperty('{@name}', this.value)">
        <xsl:if test="$allowmodifyproperties!='true'">
         <xsl:attribute name="readonly">readonly</xsl:attribute>
        </xsl:if>
       </input>
      </td>
      <xsl:if test="$showpropertydescription='true'">
       <xsl:choose>
        <xsl:when test="@description and @description!=''">
         <td><span class="propertydescription"><xsl:value-of select="@description"/></span></td>
        </xsl:when>
        <xsl:otherwise>
         <td>&#160;</td>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:if>
      <xsl:if test="$allowmodifyproperties='true'">
       <td>&#160;</td>
      </xsl:if>
     </tr>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="import" match="import" mode="import">
  <tr>
   <td align="center" style="padding:3px" nowrap="nowrap">
    <span class="importfile"><xsl:value-of select="@file"/></span>
   </td>
   <td align="center" style="padding:3px" nowrap="nowrap">
    <span class="importoptional"><xsl:value-of select="@optional"/>&#160;</span>
   </td>
   <td align="center" style="padding:3px" nowrap="nowrap">
    <input id="buttonimportfile_{position()}" type="button" value="?" title="View" onclick="window.open(expandPropertyValue('{/project/@basedir}/{@file}'), 'windowimportfile', 'toolbar=no, menubar=no, location=no, status=no, directories=no, resizable=yes, scrollbars=yes')"/>
   </td>
  </tr>
 </xsl:template>

 <xsl:template name="taskdef" match="taskdef" mode="taskdef">
  <tr>
   <td align="center" style="padding:3px" nowrap="nowrap">
    <span class="taskdefname"><xsl:value-of select="@name"/></span>
   </td>
   <td align="left" style="padding:3px" nowrap="nowrap">
    <span class="taskdefclassname"><xsl:value-of select="@classname|@file|@resource"/>&#160;</span>
   </td>
   <td align="left" style="padding:3px" nowrap="nowrap">
    <xsl:choose>
     <xsl:when test="@classpath or @classpathref">
      <span class="taskdefclasspath"><xsl:value-of select="@classpath|@classpathref"/>&#160;</span>
     </xsl:when>
     <xsl:otherwise>
      &#160;
     </xsl:otherwise>
    </xsl:choose>   
   </td>
  </tr>
 </xsl:template>

 <xsl:template name="target" match="target" mode="target">
  <xsl:choose>
   <xsl:when test="$showsubtargets='true'">
    <tr>
     <xsl:if test="$allowruntargets='true'">
      <td><input id="checkboxtarget_{@name}" type="checkbox" title="Select" onclick="swapTargetSelect('{@name}')"/></td>
      <td><input id="buttontarget_{@name}" type="button" title="Run" style="width:100%" onclick="runAnt('{@name}')"/></td>
     </xsl:if>
     <td align="center" style="padding:3px" nowrap="nowrap">
      <xsl:choose>
       <xsl:when test="@name=/project/@default">
        <span class="defaulttarget" style="cursor:pointer" title="View" onclick="viewTarget('{@name}', '{$expandproperties}')"><xsl:value-of select="@name"/></span>
       </xsl:when>
       <xsl:otherwise>
        <xsl:choose>
         <xsl:when test="@description and @description!=''">
          <span class="target" style="cursor:pointer" title="View" onclick="viewTarget('{@name}', '{$expandproperties}')"><xsl:value-of select="@name"/></span>
         </xsl:when>
         <xsl:otherwise>
          <span class="subtarget" style="cursor:pointer" title="View" onclick="viewTarget('{@name}', '{$expandproperties}')"><xsl:value-of select="@name"/></span>
         </xsl:otherwise>
        </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
     </td>
     <td align="left" style="padding:3px" nowrap="nowrap">
      <xsl:choose>
       <xsl:when test="@description and @description!=''">
        <span class="targetdescription"><xsl:value-of select="@description"/></span>
       </xsl:when>
       <xsl:otherwise>
        &#160;
       </xsl:otherwise>
      </xsl:choose>
     </td>
     <xsl:if test="$showtargetdepends='true'">
      <td align="left">
       <xsl:choose>
        <xsl:when test="@depends">
         <span class="targetdepends">
          <xsl:call-template name="splitdepends">
           <xsl:with-param name="depends">
            <xsl:value-of select="translate(@depends,' ','')"/>
           </xsl:with-param>
          </xsl:call-template>
         </span>
        </xsl:when>
        <xsl:otherwise>
         &#160;
        </xsl:otherwise>
       </xsl:choose>
      </td>
     </xsl:if>
     <xsl:if test="$showtargettasks='true'">
      <td align="left">
       <span class="targettasks">
        <xsl:variable name="childnodes" select="*"/>
        <xsl:for-each select="$childnodes">
         <xsl:if test="generate-id(.)=generate-id($childnodes[name(.)=name(current())])">
          <a style="cursor:pointer" title="Manual" onclick="getAntTaskManualURL('{name()}')"><xsl:value-of select="name(.)"/></a>
          <xsl:if test="position()!=last()">, </xsl:if>
         </xsl:if>
        </xsl:for-each>
        &#160;
       </span>
      </td>
     </xsl:if>
    </tr>
   </xsl:when>
   <xsl:otherwise>
    <xsl:if test="@description and @description!=''">
     <tr>
      <xsl:if test="$allowruntargets='true'">
       <td><input id="checkboxtarget_{@name}" type="checkbox" title="Select" onclick="swapTargetSelect('{@name}')"/></td>
       <td><input id="buttontarget_{@name}" type="button" title="Run" style="width:100%" onclick="runAnt('{@name}')"/></td>
      </xsl:if>
      <td align="center" style="padding:3px; cursor:pointer" nowrap="nowrap" title="View" onclick="viewTarget('{@name}', '{$expandproperties}')">
       <xsl:choose>
        <xsl:when test="@name=/project/@default">
         <span class="defaulttarget"><xsl:value-of select="@name"/></span>
        </xsl:when>
        <xsl:otherwise>
         <span class="target"><xsl:value-of select="@name"/></span>
        </xsl:otherwise>
       </xsl:choose>
      </td>
      <td align="left" style="padding:3px" nowrap="nowrap">
       <span class="targetdescription"><xsl:value-of select="@description"/></span>
      </td>
      <xsl:if test="$showtargetdepends='true'">
       <td>
        <xsl:choose>
         <xsl:when test="@depends">
          <span class="targetdepends">
           <xsl:call-template name="splitdepends">
            <xsl:with-param name="depends">
             <xsl:value-of select="translate(@depends,' ','')"/>
            </xsl:with-param>
           </xsl:call-template>
          </span>
         </xsl:when>
         <xsl:otherwise>
          &#160;
         </xsl:otherwise>
        </xsl:choose>
       </td>
      </xsl:if>
      <xsl:if test="$showtargettasks='true'">
       <td align="left">
        <span class="targettasks">
         <xsl:variable name="childnodes" select="*"/>
         <xsl:for-each select="$childnodes">
          <xsl:if test="generate-id(.)=generate-id($childnodes[name(.)=name(current())])">
           <a style="cursor:pointer" title="Manual" onclick="getAntTaskManualURL('{name()}')"><xsl:value-of select="name(.)"/></a>
           <xsl:if test="position()!=last()">, </xsl:if>
          </xsl:if>
         </xsl:for-each>
         &#160;
        </span>
       </td>
      </xsl:if>
     </tr>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
