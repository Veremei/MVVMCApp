import Danger
import Foundation

let danger = Danger()
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("These files have changed: \(editedFiles.joined(separator: ", "))")

report = xcov.produce_report(
    project: "MVVMCApp.xcodeproj",
    scheme: "MVVMCApp",
    minimum_coverage_percentage: 90
)
xcov.output_report(report)
