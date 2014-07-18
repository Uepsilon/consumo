$ -> 
  render_chart = (container, chart_type, chart_data) ->
    chart_type = "line"  unless chart_type
    chart = new CanvasJS.Chart(container,
      theme: "theme1"
      zoomEnabled: true
      animationEnabled: true
      axisX:
        valueFormatString: "DD. MMM YY"
        labelAngle: -50

      axisY:
        includeZero: true
        gridThickness: 1

      data: [
        type: chart_type
        toolTipContent: "<p style='\"'color: black;'\"'>{x}: <br/>{y} Bestellungen</p>"
        markerSize: 8
        markerType: "circle"
        xValueType: "dateTime"
        xValueFormatString: "DD. MMMM YYYY"
        bevelEnabled: false
        lineThickness: 4
        dataPoints: chart_data
      ]
    )
    chart.render()
    return
